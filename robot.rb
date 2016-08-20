require_relative './errors.rb'
require_relative './table.rb'

class Robot

  attr_reader :facing, :x, :y

  def initialize(table)
    @Table = table
  end
  
  # Picks up the robot and places it on a co-ordinate inside
  # the grid, facing the specified direction.
  def place(x, y, f)

    @Table.check_boundary(x,y)
 
    if !(["north","south","east","west"].include? f)
      raise RobotCmdErr.new("Malformed Place Command.")
    end

    @x = x
    @y = y
    @facing = f

  end

  # Moves robot 1 unit in the direction it is currently
  # facing. Checks the make sure the movement won't cause
  # the robot to fall off the table.
  def move
    case @facing
       when 'north'
         @y += 1 if @Table.check_boundary(@x, @y + 1)
       when 'south'
         @y -= 1 if @Table.check_boundary(@x, @y - 1)
       when 'east'
         @x += 1 if @Table.check_boundary(@x + 1, @y)
       when 'west'
         @x -= 1 if @Table.check_boundary(@x - 1, @y)
    end
  end

  def left
    rotate('left')
  end

  def right
    rotate('right')
  end

  # rotates the robot a certain direction - left or right.
  def rotate(direction)
    guide = {north: {left: 'west', right: 'east'},
    south: {left: 'east', right: 'west'},
    east: {left: 'north', right: 'south'},
    west: {left: 'south', right: 'north'}}

    @facing = guide[@facing.to_sym][direction.to_sym]
  end

  # reports the location of the robot to STDOUT
  def report
    puts "Robot is at x:#{@x}, y:#{@y}, facing #{@facing}."
  end

end
