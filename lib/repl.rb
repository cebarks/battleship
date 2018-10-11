
class Repl
  def initialize(prompt, message, hash)
    @prompt = prompt
    @message = message
    @trigger_hash = hash
  end

  def run
    puts @message
    loop do
      print @prompt
      input = get_input

      proc = get_proc_from_trigger(input)

      proc.call()
    end
  end

  def get_input
    input = $stdin.gets
    #require 'pry';binding.pry
    if input.nil?
      return ""
    end
    input.chomp.downcase
  end

  def get_proc_from_trigger(trigger)
    proc_key = []
    @trigger_hash.keys.each do |key|
      proc_key = key if key.include?(trigger)
    end

    @trigger_hash[proc_key]
  end
end
