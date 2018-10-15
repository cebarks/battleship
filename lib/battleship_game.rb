require './lib/human_player'
require './lib/ai_player'
require './lib/board'
require './lib/repl'

class BattleshipGame
  attr_reader :player_1, :player_2

  SHIP_SIZES = [2, 3].freeze

  def initialize
    @player_1 = HumanPlayer.new
    @player_2 = AIPlayer.new
    @players = [@player_1, @player_2]
    @running = false
  end

  def start
    @running = true
    @repl = Repl.new

    while @running
      trigger = @repl.run
      case trigger
      when :play
        game_init
      when :instructions
        print_instructions
      when :quit
        exit_game
      when :invalid
        puts "Invalid Input. Try Again "
      end
    end
  end

  def game_init
    @start_time = Time.now

    @player_2.place_ships
    @player_1.place_ships

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
      losing_players = check_for_losses

      unless losing_players.empty?
        end_of_game(losing_players)
        break
      end
    end
  end

  def end_of_game(losing_players)
    game_length = Time.now - @start_time
    if losing_players.size == 2
      puts 'Like in real war, you both lose.'
    else
      losing_players[0].lose
    end

    puts "This game took #{game_length.round(0)} seconds to play."
    puts "The #{@player_1.type} took #{@player_1.shots_taken} shots this game."
    puts "The #{@player_2.type} took #{@player_2.shots_taken} shots this game."
  end

  def turn(player, target)
    coord = ''

    if player.is_a?(HumanPlayer)
      puts 'Your hits and misses.'
      target.print_board(false)
      # target.print_board(true) # Make testing easier by cheating!!!!
    end
    loop do
      coord = player.get_attack_coord
      break if target.board.is_coord_valid?(coord) && !target.hit?(coord)
    end

    success = target.fire(coord)
    player.print_hit(success, coord)

    if player.is_a?(HumanPlayer)
      target.print_board(false)
      enter_to_continue
    else
      target.print_board(true)
    end
  end

  def check_for_losses
    @players.select do |player|
      player.ships.empty?
    end
  end

  def check_ships
    @players.each(&:check_ships)
  end

  def get_input
    input = $stdin.gets
    return '' if input.nil?

    input.chomp.upcase
  end

  def print_instructions
    puts 'Welcome to BATTLESHIP. The objective of this game is to sink the ships of your opponent before they sink yours. You will be asked to place your ships on a grid. Then, you will be asked where you want to fire your shots! The game is over when your or your oppenents ships have all been sunk!'
  end

  def enter_to_continue
    puts 'Press ENTER to continue.'
    puts 'Press ENTER to continue.' until get_input == ''
  end

  def exit_game
    puts "Thanks for playing!"
    @running = false
  end
end
