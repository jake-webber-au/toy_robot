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
