require_relative '../robot.rb'
require 'spec_helper'

describe 'Robot Class' do
  it 'exists and instantiates.' do
    expect(Robot.new).to be_kind_of(Robot)
  end
  it 'has an issue command' do
    expect(Robot.new).to respond_to(:issue_command)
  end
  it 'has a place command' do
    expect(Robot.new).to respond_to(:place)
  end
  it 'has an rotate command' do
    expect(Robot.new).to respond_to(:rotate)
  end
  it 'has an report command' do
    expect(Robot.new).to respond_to(:report)
  end
end 

describe 'Robot PLACE command' do
  it 'errors if the robot is not placed within 5x5 grid.' do
    r = Robot.new
    expect{r.place(0,6,'north')}.to raise_error(RobotOutOfBounds)
  end
  it 'errors if the robot is not given a valid direction.' do
    r = Robot.new
    expect{r.place(0,5,'northh')}.to raise_error(RobotCmdErr)
  end
  it 'does not accept invalid command as initial placement.' do
    r = Robot.new
    expect{r.place(0,5,'northh')}.to raise_error(RobotCmdErr)
    expect(r.instance_variable_get(:@initial_placement)).to eq(nil)
  end
  it 'places robot with correct values and accepts initial placement.' do
    r = Robot.new
    r.place(0,5,'north')
    expect(r.instance_variable_get(:@x)).to eq(0)
    expect(r.instance_variable_get(:@y)).to eq(5)
    expect(r.instance_variable_get(:@facing)).to eq('north')
    expect(r.instance_variable_get(:@initial_placement)).to eq(true)
  end
end 

describe 'Robot MOVE command' do

  context 'fall prevention' do
    it 'prevents falling off the tabletop to the north' do
      r = Robot.new
      r.place(0,5,'north')
      expect{r.move}.to raise_error(RobotOutOfBounds)
    end

    it 'prevents falling off the tabletop to the south' do
      r = Robot.new
      r.place(5,0,'south')
      expect{r.move}.to raise_error(RobotOutOfBounds)
    end

    it 'prevents falling off the tabletop to the east' do
      r = Robot.new
      r.place(5,2,'east')
      expect{r.move}.to raise_error(RobotOutOfBounds)
    end

    it 'prevents falling off the tabletop to the west' do
      r = Robot.new
      r.place(0,5,'west')
      expect{r.move}.to raise_error(RobotOutOfBounds)
    end
  end

  context 'advance commands' do
    it 'advances north by one unit' do
      r = Robot.new
      r.place(0,4,'north')
      r.move
      expect(r.instance_variable_get(:@y)).to eq(5)
      expect(r.instance_variable_get(:@x)).to eq(0)
    end

    it 'advances south by one unit' do
      r = Robot.new
      r.place(0,4,'south')
      r.move
      expect(r.instance_variable_get(:@y)).to eq(3)
      expect(r.instance_variable_get(:@x)).to eq(0)
    end

    it 'advances east by one unit' do
      r = Robot.new
      r.place(0,4,'east')
      r.move
      expect(r.instance_variable_get(:@y)).to eq(4)
      expect(r.instance_variable_get(:@x)).to eq(1)
    end

    it 'advances west by one unit' do
      r = Robot.new
      r.place(2,0,'west')
      r.move
      expect(r.instance_variable_get(:@x)).to eq(1)
      expect(r.instance_variable_get(:@y)).to eq(0)
    end
  end
end 

describe 'Robot ROTATE command' do
    it 'rotates left correctly' do
      r = Robot.new
      r.place(0,5,'north')
      r.rotate('left')
      expect(r.instance_variable_get(:@facing)).to eq('west')
    end

    it 'rotates right correctly' do
      r = Robot.new
      r.place(0,5,'south')
      r.rotate('right')
      expect(r.instance_variable_get(:@facing)).to eq('west')
    end
end 

describe 'Robot REPORT command' do
    it 'reports position and direction to STDOUT' do
      r = Robot.new
      r.place(0,5,'south')
      message = "Robot is at x:0, y:5, facing south.\n"
      expect {r.report }.to output(message).to_stdout
    end
end

describe 'Robot issue command (integration testing)' do
    it 'reports not placed yet error to STDOUT' do
      r = Robot.new
      move_cmd = {"type" => "move"}
      message = "Command 'move' ignored - Reason: Not Placed Yet.\n"
      expect {r.issue_command(move_cmd)}.to output(message).to_stdout
    end
    it 'reports out of bounds errors to STDOUT' do
      r = Robot.new
      r.issue_command({"type" => "place", "x"=>1, "y"=>5, "facing"=>"north"})
      message = "Command 'move' ignored - Reason: Command would result in falling.\n"
      expect {r.issue_command({"type" => "move"})}.to output(message).to_stdout
    end
    it 'forwards command if placed correctly' do
      r = Robot.new
      r.issue_command({"type" => "place", "x"=>1, "y"=>2, "facing"=>"north"})
      r.issue_command({"type" => "move"})
      expect(r.instance_variable_get(:@x)).to eq(1)
      expect(r.instance_variable_get(:@y)).to eq(3)
    end
    it 'ignores invalid initial placement command' do
      r = Robot.new
      r.issue_command({"type" => "place", "x"=>6, "y"=>2, "facing"=>"north"})
      r.issue_command({"type" => "move"})
      r.issue_command({"type" => "place", "x"=>1, "y"=>1, "facing"=>"east"})
      r.issue_command({"type" => "move"})
      r.issue_command({"type" => "move"})
      r.issue_command({"type" => "right"})
      expect(r.instance_variable_get(:@x)).to eq(3)
      expect(r.instance_variable_get(:@y)).to eq(1)
      expect(r.instance_variable_get(:@facing)).to eq("south")
    end
    it 'ignores invalid move commands' do
      r = Robot.new
      r.issue_command({"type" => "place", "x"=>5, "y"=>5, "facing"=>"north"})
      r.issue_command({"type" => "move"})
      r.issue_command({"type" => "place", "x"=>1, "y"=>4, "facing"=>"west"})
      r.issue_command({"type" => "move"})
      r.issue_command({"type" => "right"})
      expect(r.instance_variable_get(:@x)).to eq(0)
      expect(r.instance_variable_get(:@y)).to eq(4)
      expect(r.instance_variable_get(:@facing)).to eq("north")
    end
    it 'forwards left/right command' do
      r = Robot.new
      r.issue_command({"type" => "place", "x"=>1, "y"=>2, "facing"=>"north"})
      r.issue_command({"type" => "left"})
      r.issue_command({"type" => "right"})
      r.issue_command({"type" => "right"})
      expect(r.instance_variable_get(:@facing)).to eq('east')
    end
end