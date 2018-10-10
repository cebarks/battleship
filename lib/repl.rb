
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

      code = @trigger_hash[input]

      code.call()
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

  def block_to_proc
    Proc.new { yield }
  end
end
