# require File.expand_path '../game_of_life', __FILE__
require 'pry'
# require './board.rb'

require 'drawille'
require 'curses'
require './board.rb'

Curses::init_screen()

puts "Curses.lines: #{Curses.lines}"
puts "Cursed.cols: #{Curses.cols * 2 - 2}"
# board   = Board.new 4, 4
board = Board.new Curses.lines * 4, Curses.cols * 2 - 2

flipbook = Drawille::FlipBook.new

flipbook.play do
  canvas = board.to_canvas
  board.tick
  canvas
end

# def play(iterations)
#   puts "play #{iterations} iterations"
#   game = Board.new(40, 20)
#   # oscillators:
#   # game.load [2,20], [2,21], [2,22]
#   # game.load [2,10], [2,11], [2,12], [3,9], [3,10], [3,11]
#
#   # glider:
#   # game.load [2,1], [2,2], [2,3], [1,3], [0,2]
#   i = 0
#   while i <= iterations
#     print "\e[2J\e[f"
#     puts game.to_s.gsub('0', ' ').gsub('1', '@')
#     game.tick
#     sleep 0.1
#     i += 1
#   end
# end
#
# play(15)
