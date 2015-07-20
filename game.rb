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
