require_relative 'util.rb'
require_relative 'robot.rb'

# load commands via JsonCmdUtil
instructions = Utilities.load_json_commands(ARGV[0])

# create our robot and issue commands.
robot = Robot.new
instructions["commands"].each do |step|
  robot.issue_command(step)
end