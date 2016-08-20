require_relative '../Robot.rb'
require_relative '../CommandRunner.rb'
require 'spec_helper'

describe 'Robot Class' do
  before(:each) do
    table = Table.new
    @r = Robot.new(table)
  end

  it 'exists and instantiates.' do
    expect(@r).to be_kind_of(Robot)
  end
  it 'has a place command' do
    expect(@r).to respond_to(:place)
  end
  it 'has an rotate command' do
    expect(@r).to respond_to(:rotate)
  end
  it 'has an report command' do
    expect(@r).to respond_to(:report)
  end
end 

describe 'Robot PLACE command' do
  before(:each) do
    table = Table.new
    @r = Robot.new(table)
  end

  it 'errors if the robot is not placed within 5x5 grid.' do
    expect{@r.place(0,6,'north')}.to raise_error(RobotOutOfBounds)
  end
  it 'errors if the robot is not given a valid direction.' do
    expect{@r.place(0,5,'northh')}.to raise_error(RobotCmdErr)
  end
  it 'does not accept invalid command as initial placement.' do
    expect{@r.place(0,5,'northh')}.to raise_error(RobotCmdErr)
    expect(@r.instance_variable_get(:@facing)).to eq(nil)
  end
  it 'places robot with correct values and accepts initial placement.' do
    @r.place(0,5,'north')
    expect(@r.instance_variable_get(:@x)).to eq(0)
    expect(@r.instance_variable_get(:@y)).to eq(5)
    expect(@r.instance_variable_get(:@facing)).to eq('north')
  end
end 

describe 'Robot MOVE command' do

  before(:each) do
    table = Table.new
    @r = Robot.new(table)
  end

  context 'fall prevention' do
    it 'prevents falling off the tabletop to the north' do
      @r.place(0,5,'north')
      expect{@r.move}.to raise_error(RobotOutOfBounds)
    end

    it 'prevents falling off the tabletop to the south' do
      @r.place(5,0,'south')
      expect{@r.move}.to raise_error(RobotOutOfBounds)
    end

    it 'prevents falling off the tabletop to the east' do
      @r.place(5,2,'east')
      expect{@r.move}.to raise_error(RobotOutOfBounds)
    end

    it 'prevents falling off the tabletop to the west' do
      @r.place(0,5,'west')
      expect{@r.move}.to raise_error(RobotOutOfBounds)
    end
  end

  context 'advance commands' do
    it 'advances north by one unit' do
      @r.place(0,4,'north')
      @r.move
      expect(@r.instance_variable_get(:@y)).to eq(5)
      expect(@r.instance_variable_get(:@x)).to eq(0)
    end

    it 'advances south by one unit' do
      @r.place(0,4,'south')
      @r.move
      expect(@r.instance_variable_get(:@y)).to eq(3)
      expect(@r.instance_variable_get(:@x)).to eq(0)
    end

    it 'advances east by one unit' do
      @r.place(0,4,'east')
      @r.move
      expect(@r.instance_variable_get(:@y)).to eq(4)
      expect(@r.instance_variable_get(:@x)).to eq(1)
    end

    it 'advances west by one unit' do
      @r.place(2,0,'west')
      @r.move
      expect(@r.instance_variable_get(:@x)).to eq(1)
      expect(@r.instance_variable_get(:@y)).to eq(0)
    end
  end
end 

describe 'Robot ROTATE command' do
  before(:each) do
    table = Table.new
    @r = Robot.new(table)
  end

  it 'rotates left correctly' do
    @r.place(0,5,'north')
    @r.rotate('left')
    expect(@r.instance_variable_get(:@facing)).to eq('west')
  end

  it 'rotates right correctly' do
    @r.place(0,5,'south')
    @r.rotate('right')
    expect(@r.instance_variable_get(:@facing)).to eq('west')
  end
end 

describe 'Robot REPORT command' do
  it 'reports position and direction to STDOUT' do
    table = Table.new
    r = Robot.new(table)
    r.place(0,5,'south')
    message = "Robot is at x:0, y:5, facing south.\n"
    expect {r.report }.to output(message).to_stdout
  end
end