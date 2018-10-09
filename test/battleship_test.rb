require './test/test_helper'

require './lib/battleship_game'

class BattleshipTest < Minitest::Test
  def setup
    @battleship = BattleshipGame.new
  end

  def test_it_creates
    assert_instance_of BattleshipGame, @battleship
  end

  def test_print_instructions
    assert_output "Welcome to BATTLESHIP. The objective of this game is to sink the ships of your opponent before they sink yours. You will be asked to place your ships on a grid. Then, you will be asked where you want to fire your shots! The game is over when your or your oppenents ships have all been sunk!\n" do
      @battleship.print_instructions
    end
  end

  def test_has_players
    assert_instance_of Player, @battleship.player_1
    assert_instance_of Player, @battleship.player_2
  end

  def test_welcome_repl
    skip
    out, err = capture_io do
      simulate_stdin('i') { @battleship.welcome }
    end
    out = 'Hello, World!'
    puts out
    #  %x(echo "#{out}" > test.txt)

    assert true
    # p out, err
  end

  def test_get_input
    input = ''
    simulate_stdin('test1') { input = @battleship.get_input }
    assert_equal 'test1', input
  end

  def test_get_input_if_nil
    input = ''
    simulate_stdin() { input = @battleship.get_input }
    assert_equal '', input
  end

  def test_exit_game
    # skip
    assert_output "Thanks for playing!\n" do
      @battleship.exit_game
    end
  end
end