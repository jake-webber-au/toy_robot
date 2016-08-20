require_relative './errors.rb'

class Robot
  
  # public interface for command processing for the robot.
  # ensures the order of the commands are correct and handles
  # erroneous commands 
  def issue_command(cmd)

  end

  # Picks up the robot and places it on a co-ordinate inside
  # the grid, facing the specified direction.
  # Must be the first command for a robot prior to all other
  # movement commands.
  def place(x,y,facing)

    if !x.between?(0,5) || !y.between?(0,5)
      raise RobotOutOfBounds.new
    end

    if !(["north","south","east","west"].include? facing)
      raise RobotCmdErr.new("Malformed Place Command.")
    end

    @x = x
    @y = y
    @facing = facing

    if @initial_placement != true
      @initial_placement = true
    end

  end

  # Moves robot 1 unit in the direction it is currently
  # facing. We need to ensure that the command doesn't
  # cause the robot to fall off the table so we will throw
  # an OutOfBounds error.
  def move
      case @facing
       when 'north'
        if @y >= 5 then raise RobotOutOfBounds.new end
        @y += 1
       when 'south'
        if @y == 0 then raise RobotOutOfBounds.new end
        @y -= 1 
       when 'east'
        if @x >= 5 then raise RobotOutOfBounds.new end
        @x += 1
       when 'west'
        if @x == 0 then raise RobotOutOfBounds.new end
        @x -= 1
     end
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
  end

end
