
class Repl
  def initialize
    @prompt = '>'
    @message = %{Welcome to BATTLESHIP!
    Would you like to (p)lay, read the (i)nstructions, or (q)uit?}
    @trigger_hash = {
      %w[p play] => :play,
      %w[i instructions] => :instructions,
      %w[q quit] => :quit
    }
    @trigger_hash.default = :invalid
  end

  def run
      puts @message
      print @prompt
      get_response_from_trigger(Repl.get_input)
  end

  def get_response_from_trigger(trigger)
    trigger_key = []
    @trigger_hash.keys.each do |key|
      if key.include?(trigger)
        trigger_key = key
        break
      end
    end

    @trigger_hash[trigger_key]
  end

  ##
  # This input returns a non-nil string of the input pulled from $stdin
  #
  def self.get_input
    input = $stdin.gets
    if input.nil?
      return ""
    end
    input.chomp
  end
end
