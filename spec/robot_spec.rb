require_relative '../robot.rb'

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
end 
