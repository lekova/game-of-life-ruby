require 'pry'
require './cell.rb'

class Board
  attr_reader :grid
  attr_accessor :rows, :cols

  def initialize rows, cols
    @grid = Array.new(rows) { Array.new(cols) }
    @rows, @cols = rows, cols
    init_board
  end

  def init_board
    for i in (0..@rows - 1)
      for j in (0..@cols - 1)
        @grid[i][j] = Cell.new false
        @grid[i][j].set_random
      end
    end
  end

  def print_board
    result = Array.new(@rows) { Array.new(@cols) }
    for i in (0..@rows - 1)
      for j in (0..@cols - 1)
        result[i][j] = 1 if @grid[i][j].is_alive
        result[i][j] = 0 if !@grid[i][j].is_alive
      end
      print "#{result[i]} \n"
    end
  end

  def get_neighbors x, y
    num_of_neighbors = 0

    if x - 1 >= 0 && y - 1 >= 0 && y < @cols && @grid[x - 1][y - 1].is_alive
      num_of_neighbors += 1
    end

    if x - 1 >= 0 && y >= 0 && @grid[x - 1][y].is_alive
      num_of_neighbors += 1
    end

    if x - 1 >= 0 && y + 1 < @cols && @grid[x - 1][y + 1].is_alive
      num_of_neighbors += 1
    end

    if y - 1 >= 0 && @grid[x][y - 1].is_alive
      num_of_neighbors += 1
    end

    if y + 1 < @cols && @grid[x][y + 1].is_alive
      num_of_neighbors += 1
    end

    if x + 1 < @rows && y - 1 >= 0 && @grid[x + 1][y - 1].is_alive
      num_of_neighbors += 1
    end

    if x + 1 < @rows && @grid[x + 1][y].is_alive
      num_of_neighbors += 1
    end

    if x + 1 < @rows && y + 1 < @cols && @grid[x + 1][y + 1].is_alive
      num_of_neighbors += 1
    end

    num_of_neighbors
  end

  def tick
    new_grid = Array.new(rows) { Array.new(cols) }

    for i in (0..@rows-1)
      for j in (0..@cols-1)
        neighbors = get_neighbors i, j
        # puts "neighbors for[#{i}][#{j}]: #{neighbors}"
        if @grid[i][j].is_alive && ( neighbors < 2 || neighbors > 3 )
          new_grid[i][j] = Cell.new(false)
        elsif @grid[i][j].is_alive && (neighbors == 2 || neighbors == 3)
          new_grid[i][j] = Cell.new(true)
        elsif !@grid[i][j].is_alive && neighbors == 3
          new_grid[i][j] = Cell.new(true)
        else
          new_grid[i][j] = @grid[i][j]
        end
      end
    end

    @grid = new_grid
    sleep 0.1
  end

  def to_canvas
    canvas = Drawille::Canvas.new

    each_grid do |x, y|
      canvas.set(x, y) if x < @rows && y < @cols && @grid[x][y].is_alive == true
    end
    canvas
  end

  private

  def each_grid
    (0...@rows).each do |y|
      (0...@cols).each do |x|
        yield x, y
      end
    end
  end
end
