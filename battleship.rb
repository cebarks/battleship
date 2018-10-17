
require './lib/battleship_game'

args = ARGV

battleship = BattleshipGame.new(args)
battleship.start()
