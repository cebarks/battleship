
class Repl
  def initialize(prompt, message, hash)
    @prompt = prompt
    @message = message
    @trigger_hash = hash
    @continue = true
  end

  def run
    loop do
      break if !@continue
      puts @message
      print @prompt
      input = get_input

      proc = get_proc_from_trigger(input)

      proc.call()
      break if !@continue
    end
  end

  def stop
    @continue = false
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
