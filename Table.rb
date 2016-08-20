require_relative './errors.rb'

class Table

  def initialize(x = 5, y= 5)
    @x = x
    @y = y
  end
  
  def check_boundary(x,y)
    if !x.between?(0,@x) || !y.between?(0,@y)
      raise RobotOutOfBounds.new
    end
    return true
  end
end
