require_relative 'util.rb'
require_relative 'Robot.rb'
require_relative 'CommandRunner.rb'

# load commands via JsonCmdUtil
instructions = Utilities.load_json_commands(ARGV[0])

# create our robot and issue commands.
robot = Robot.new(Table.new)
cr = CommandRunner.new(robot)
instructions[:commands].each do |step|
  cr.issue_command(step)
end