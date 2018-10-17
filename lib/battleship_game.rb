require './lib/human_player'
require './lib/ai_player'
require './lib/board'
require './lib/repl'
require './lib/timer'

class BattleshipGame
  attr_reader :player_1, :player_2, :options

    @@SHIP_SIZES = (2..3).to_a
    @@OPTIONS = {
      :debug => false,
      :board => {
        :size => 4
      },
      :ships => {
        :number => 2
      }, 
      :quit => false
    }
    
    def self.ship_sizes
      @@SHIP_SIZES
    end

    def self.options
      @@OPTIONS
    end
  
  def initialize
    @running = false
    @options = @@OPTIONS
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
      when :options
        options
      when :quit
        exit_game
      when :invalid
        puts "Invalid Input. Try Again "
      end
    end
  end
  
  def options
    print_options
    boolean_break = true
    while boolean_break do
      puts "Enter the option you want to change: #{@options.keys.join(", ")}"
      
      until @options.keys.include?(choice = get_input.downcase.to_sym)
        puts "Enter the option you want to change: #{@options.keys.join(", ")}"
      end
      
      case choice
      when :board
        puts "Enter the option you want to change: #{@options[:board].keys.join(", ")}"
        
        until @options[:board].keys.include?(board_choice = get_input.downcase.to_sym)
          puts "Enter the option you want to change: #{@options[:board].keys.join(", ")}"
        end

        case board_choice
        when :size
          puts "How long would you like the rows/columns to be?"
          new_size = get_input.to_i
          @options[:board][:size] = new_size
        end
      when :ships
        puts "Enter the option you want to change: #{@options[:ships].keys.join(", ")}"
        
        until @options[:ships].keys.include?(ships_choice = get_input.downcase.to_sym)
          puts "Enter the option you want to change: #{@options[:ships].keys.join(", ")}"
        end

        case ships_choice
        when :number
          puts "How many ships do you want?"
          new_number = get_input.to_i
          @options[:ships][:number] = new_number
        end
        
      when :debug
        @options[:debug] = !@options[:debug]
        puts "Toggled Debug Mode to #{@options[:debug]}"
      when :quit
        boolean_break = false
      end
    end
    @@SHIP_SIZES = (2...(@options[:ships][:number] + 2)).to_a
    @@BOARD_SIZE = @options[:board][:size]
    @@OPTIONS = @options
  end

  def print_options
    puts "Current settings:"
    @options.keys.each do |key|
      print_option(key) unless key == :quit
    end
  end

  def print_option(key)
    option = @options[key]
    
    if option.is_a?(Hash)
      puts "-" + "#{key}:"
      option.each do |k, v|
        puts "  --" + "#{k}: #{v}"
      end
    else
      puts "-" + "#{key}: #{option}"
    end
  end
  
  def create_players
    @player_1 = HumanPlayer.new
    @player_2 = AIPlayer.new
    @players = [@player_1, @player_2]
  end
  
  def game_init
    @timer = Timer.new
    @timer.start
    
    create_players
    
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
    game_length = @timer.stop.total(2)
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
    target.print_board

    loop do
      coord = player.get_attack_coord
      break if target.board.is_coord_valid?(coord) && !target.hit?(coord)
    end

    success = target.fire(coord)
    player.add_guess(coord, success)
    player.print_hit(success, coord)

    target.print_board
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
