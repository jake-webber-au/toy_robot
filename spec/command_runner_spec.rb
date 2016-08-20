require 'spec_helper'

describe 'CommandRunner Class' do
  before(:each) do
    table = Table.new
    @robot = Robot.new(table)
    @runner = CommandRunner.new(@robot)
  end

  it 'exists and instantiates.' do
    expect(@runner).to be_kind_of(CommandRunner)
  end
  it 'has a public function that allows us to pass commands.' do
    expect(@runner).to respond_to(:issue_command)
  end
end

describe 'Robot issue command' do
  before(:each) do
    table = Table.new
    @robot = Robot.new(table)
    @runner = CommandRunner.new(@robot)
  end
  it 'reports not placed yet error to STDOUT' do
    move_cmd = {:type => "move"}
    message = "Command 'move' ignored - Reason: Not Placed Yet.\n"
    expect {@runner.issue_command(move_cmd)}.to output(message).to_stdout
  end
  it 'reports out of bounds errors to STDOUT' do
    @runner.issue_command({:type => "place", :options => { :x=>1, :y=>5, :f=>"north"}})
    expect(@r.instance_variable_get(:@facing)).to eq(nil)
  end
  it 'forwards command if placed correctly' do
    @runner.issue_command({:type => "place", :options => { :x=>1, :y=>2, :f=>"north"}})
    @runner.issue_command({:type => "move"})
    expect(@robot.instance_variable_get(:@x)).to eq(1)
    expect(@robot.instance_variable_get(:@y)).to eq(3)
  end
  it 'ignores invalid initial placement command' do
    @runner.issue_command({:type => "place", :options => {:x=>6, :y=>2, :f=>"north"}})
    @runner.issue_command({:type => "move"})
    @runner.issue_command({:type => "place", :options => {:x=>1, :y=>1, :f=>"east"}})
    @runner.issue_command({:type => "move"})
    @runner.issue_command({:type => "move"})
    @runner.issue_command({:type => "right"})
    expect(@robot.instance_variable_get(:@x)).to eq(3)
    expect(@robot.instance_variable_get(:@y)).to eq(1)
    expect(@robot.instance_variable_get(:@facing)).to eq("south")
  end
  it 'ignores invalid move commands' do
    @runner.issue_command({:type => "place", :options => {:x=>5, :y=>5, :f=>"north"}})
    @runner.issue_command({:type => "move"})
    @runner.issue_command({:type => "right"})
    @runner.issue_command({:type => "right"})
    @runner.issue_command({:type => "move"})
    expect(@robot.instance_variable_get(:@x)).to eq(5)
    expect(@robot.instance_variable_get(:@y)).to eq(4)
    expect(@robot.instance_variable_get(:@facing)).to eq("south")
  end
  it 'forwards left/right command' do
    @runner.issue_command({:type => "place", :options => {:x=>1, :y=>2, :f=>"north"}})
    @runner.issue_command({:type => "left"})
    @runner.issue_command({:type => "right"})
    @runner.issue_command({:type => "right"})
    expect(@robot.instance_variable_get(:@facing)).to eq('east')
  end
end