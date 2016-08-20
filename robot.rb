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
  end

  # Advances robot 1 unit in the direction it is currently
  # facing. We need to ensure that the command doesn't
  # cause the robot to fall off the table.
  def advance 
  end

  # rotates the robot a certain direction - left or right.
  def rotate(direction)
  end

  # reports the location of the robot to STDOUT
  def report
  end

end
