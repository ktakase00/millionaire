require './models/player'

require './models/card'
require './models/complayer'
require './models/game'
require './models/library'
require './models/manplayer'
require './models/playfield'

# str = STDIN.gets
# p str

PLAYERS_COUNT = 2
JOKER_COUNT = 1
game = Game.new(PLAYERS_COUNT, JOKER_COUNT)
game.start