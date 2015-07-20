require 'drawille'
require 'curses'
require './board.rb'

Curses::init_screen()

board = Board.new Curses.lines * 4, Curses.cols * 2 - 2
flipbook = Drawille::FlipBook.new

flipbook.play do
  canvas = board.to_canvas
  board.tick
  canvas
end
