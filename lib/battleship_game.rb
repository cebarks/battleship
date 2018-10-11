require './lib/human_player'
require './lib/ai_player'
require './lib/board'
require './lib/repl'

class BattleshipGame
  attr_reader :player_1, :player_2

  SHIP_SIZES = [2, 3]

  def initialize
    @player_1 = HumanPlayer.new
    @player_2 = AIPlayer.new
  end

  def start
    repl_procs = {
      %w[p play] => method(:game_init),
      %w[i instructions] => method(:print_instructions),
      %w[q quit] => method(:exit_game)
    }

    message =
      %{Welcome to BATTLESHIP!
      Would you like to (p)lay, read the (i)nstructions, or (q)uit?}

    @repl = Repl.new('> ', message, repl_procs)

    @repl.run
  end

  def game_init
    @player_2.place_ships
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
