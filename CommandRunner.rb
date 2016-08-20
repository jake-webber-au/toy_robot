require_relative './robot.rb'

class CommandRunner

  def initialize(robot)
    @robot = robot
  end

  # passes a command to the robot assigned to the command runner.
  def issue_command(cmd)
    begin
      check_initial_placement if cmd[:type] != 'place'
      check_method(cmd)
      args = build_args(cmd) || []
      send_to_robot(cmd, args)
    rescue RobotCmdErr, RobotOutOfBounds => e
      puts "Command '#{cmd[:type]}' ignored - Reason: #{e.message}"
    else
      puts "Command '#{cmd[:type]}' succeeded."
    end
  end

  private

  # ensures the command passed matches a method on the robot.
  def check_method(cmd)
    if !Robot.method_defined? cmd[:type]
      raise RobotCmdErr.new("Command doesn't exist.")
    end
  end

  # pulls the parameters required for the method on the robot.
  def get_method_params(command)
    params = Robot.instance_method(command.to_sym)
      .parameters.map(&:last)
      .map(&:to_s)
  end

  # builds arguments from the command input, ensuring that all
  # parameters of the associated method are presented within the 
  # command. returns arguments in an array.
  def build_args(cmd)
    if !cmd[:options].nil?
      options = cmd[:options].map(&:first)
      args = []
      params = get_method_params(cmd[:type])
      params.each do |params|
        if !options.include? params.to_sym
          raise RobotCmdErr.new("Missing #{params} parameter in '#{cmd[:type]}'")
        end
        args << cmd[:options][params.to_sym]
      end
      return args
    end
  end

  # dispatches the command to the associated robot.
  def send_to_robot(cmd, args)
    @robot.send(cmd[:type], *args)
  end

  def check_initial_placement
    if !@robot.facing
      raise RobotCmdErr.new("Not Placed Yet.")
    end
  end

end