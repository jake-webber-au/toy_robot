class RobotOutOfBounds < StandardError
  attr_reader :message

  def initialize
    @message = "Command would result in falling."
  end
end

# because we need to ignore invalid commands, we create a custom
# error so that we can adequately rescue it.
class RobotCmdErr < StandardError
  attr_reader :message

  def initialize(message)
    @message = message
  end
end
