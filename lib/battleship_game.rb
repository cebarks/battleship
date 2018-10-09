require './lib/player'
require './lib/board'

class BattleshipGame
  attr_reader :player_1, :player_2, :board

  def initialize
    @player_1 = Player.new
    @player_2 = Player.new
    @board = Board.new

  end

  def start
    welcome
    game_loop

  end

  def welcome
    loop do
      puts "Welcome to BATTLESHIP"
      puts "Would you like to (p)lay, read the (i)nstructions, or (q)uit?"
      print "> "
      input = get_input

      case input
      when "p", "play"
        game_loop
      when "i", "instructions"
        print_instructions
      when "q", "quit"
        exit_game
      end
    end

  end

  def game_loop

  end

  def print_instructions
    puts "Welcome to BATTLESHIP. The objective of this game is to sink the ships of your opponent before they sink yours. You will be asked to place your ships on a grid. Then, you will be asked where you want to fire your shots! The game is over when your or your oppenents ships have all been sunk!"
  end

  def get_input
    input = $stdin.gets
    #require 'pry';binding.pry
    if input.nil?
      return ""
    end
    input.chomp.downcase
  end

  def exit_game
    puts "Thanks for playing!"
    @running = false
  end
end
