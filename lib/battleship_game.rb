require './lib/player'
require './lib/board'
require './lib/repl'

class BattleshipGame
  attr_reader :player_1, :player_2

  def start
    welcome
  end

  def welcome
    play_proc = Proc.new do
      game_init
    end

    instructions_proc = Proc.new do
      print_instructions
    end

    exit_proc = Proc.new do
      exit_game
    end

    repl_procs = {
      "p" => play_proc,
      "i" => instructions_proc,
      "q" => exit_proc
    }

    message =
%{Welcome to BATTLESHIP!
Would you like to (p)lay, read the (i)nstructions, or (q)uit?}

    repl = Repl.new('> ', message, repl_procs)

    repl.run
  end

  def game_init
    @player_1 = HumanPlayer.new
    @player_2 = AIPlayer.new

    @player_2.place_ships()
    @player_1.place_ships()

    game_loop
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
