class RobotOutOfBounds < StandardError
  attr_reader :message

  def initialize
    @message = "Command would result in falling."
  end
end
