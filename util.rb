require 'json'

class Utilities

  # pass a path to a JSON command definition.
  def self.load_json_commands(path)
    file = File.read(path)
    instructions = JSON.parse(file)
    return instructions
  end

end
