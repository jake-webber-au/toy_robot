require 'spec_helper'

describe 'Table Class' do
  it 'exists and instantiates.' do
    expect(Table.new).to be_kind_of(Table)
  end
  it 'has a function that checks boundaries.' do
    expect(Table.new).to respond_to(:check_boundary)
  end
end

describe 'Check Boundary function'  do
  it 'raises an error if it exceeds the northern boundary' do
    t = Table.new(2,2)
    expect{t.check_boundary(0,3)}.to raise_error(RobotOutOfBounds)
  end
  it 'raises an error if it exceeds the southern boundary' do
    t = Table.new(2,-1)
    expect{t.check_boundary(0,3)}.to raise_error(RobotOutOfBounds)
  end
  it 'raises an error if it exceeds the eastern boundary' do
    t = Table.new(2,2)
    expect{t.check_boundary(5,1)}.to raise_error(RobotOutOfBounds)
  end
  it 'raises an error if it exceeds the western boundary' do
    t = Table.new(0,2)
    expect{t.check_boundary(-1,3)}.to raise_error(RobotOutOfBounds)
  end
  it 'returns true within proper boundary' do
    t = Table.new(2,2)
    expect(t.check_boundary(1,1)).to eq(true)
  end
end
