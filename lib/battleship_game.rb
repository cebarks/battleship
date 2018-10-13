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
    @players = [@player_1, @player_2]
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
    @player_1.print_board(true)
    puts "May the best player win!"
    enter_to_continue

    game_loop
  end

  def game_loop
    loop do
      puts '-' * 30
      puts "NEXT ROUND\n"
      turn(@player_2, @player_1)
      enter_to_continue
      turn(@player_1, @player_2)

      check_ships
    end
  end


  def turn(player, target)
    coord = ""

    if player.is_a?(HumanPlayer)
      puts "Your hits and misses."
      #target.print_board(false)
      target.print_board(true) # Make testing easier by cheating!!!!
    end
    loop do
      coord = player.get_attack_coord
      if target.board.is_coord_valid?(coord) && !target.hit?(coord)
        break
      end
      if player.is_a?(HumanPlayer)
        puts "That's not a valid coord to fire upon! Try again"
      end
    end

    success = target.fire(coord)

    if player.is_a?(HumanPlayer)
      target.print_board(false)
      if success
        puts "Congrats! You hit a ship!"
      else
        puts "You missed! So sad. Stop firing at whales."
      end

      enter_to_continue

    else
      puts "AI is thinking..."
      sleep(1)
      if success
        puts "So sad. Your ship at #{coord} was hit!"
      else
        puts "Yay! Your enemy missed their shot fired at #{coord}"
      end

      puts "The current state of your board."
      target.print_board(true)
    end
  end

  def print_instructions
    puts 'Welcome to BATTLESHIP. The objective of this game is to sink the ships of your opponent before they sink yours. You will be asked to place your ships on a grid. Then, you will be asked where you want to fire your shots! The game is over when your or your oppenents ships have all been sunk!'
  end

  def enter_to_continue
    puts "Press ENTER to continue."
    until get_input == ""
      puts "Press ENTER to continue."
    end
  end

  def check_ships
    @players.each do |player|
      player.check_ships
    end
  end

  def get_input
    input = $stdin.gets
    return '' if input.nil?

    input.chomp.upcase
  end

  def exit_game
    puts 'Thanks for playing!'
    @repl.stop
  end
end
