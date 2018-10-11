require './lib/human_player'
require './lib/board'
require './lib/repl'

class BattleshipGame
  attr_reader :player_1, :player_2

  def start
    welcome
  end

  def welcome
    play_proc = proc do
      game_init
    end

    instructions_proc = proc do
      print_instructions
    end

    exit_proc = proc do
      exit_game
    end

    repl_procs = {
      %w[p play] => play_proc,
      %w[i instructions] => instructions_proc,
      %w[q quit] => exit_proc
    }

    message =
      %{Welcome to BATTLESHIP!
      Would you like to (p)lay, read the (i)nstructions, or (q)uit?}

    @repl = Repl.new('> ', message, repl_procs)

    @repl.run
  end

  def game_init
    @player_1 = HumanPlayer.new
    #@player_2 = AIPlayer.new

    #@player_2.place_ships
    @player_1.place_ships

    game_loop
  end

  def game_loop; end

  def print_instructions
    puts 'Welcome to BATTLESHIP. The objective of this game is to sink the ships of your opponent before they sink yours. You will be asked to place your ships on a grid. Then, you will be asked where you want to fire your shots! The game is over when your or your oppenents ships have all been sunk!'
  end

  def get_input
    input = $stdin.gets
    # require 'pry';binding.pry
    return '' if input.nil?

    input.chomp.downcase
  end

  def exit_game
    puts 'Thanks for playing!'
    @repl.stop
  end
end
