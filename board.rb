require 'pry'

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
        @grid[i][j] = set_random
      end
    end
  end

  def set_random
    Random.rand(2) == 1 ? true : false
  end

  def get_neighbors x, y
    num_of_neighbors = 0

    if x - 1 >= 0 && y - 1 >= 0 && y < @cols && @grid[x - 1][y - 1]
      num_of_neighbors += 1
    end

    if x - 1 >= 0 && y >= 0 && @grid[x - 1][y]
      num_of_neighbors += 1
    end

    if x - 1 >= 0 && y + 1 < @cols && @grid[x - 1][y + 1]
      num_of_neighbors += 1
    end

    if y - 1 >= 0 && @grid[x][y - 1]
      num_of_neighbors += 1
    end

    if y + 1 < @cols && @grid[x][y + 1]
      num_of_neighbors += 1
    end

    if x + 1 < @rows && y - 1 >= 0 && @grid[x + 1][y - 1]
      num_of_neighbors += 1
    end

    if x + 1 < @rows && @grid[x + 1][y]
      num_of_neighbors += 1
    end

    if x + 1 < @rows && y + 1 < @cols && @grid[x + 1][y + 1]
      num_of_neighbors += 1
    end

    num_of_neighbors
  end

  def tick
    new_grid = Array.new(rows) { Array.new(cols) }

    for i in (0..@rows-1)
      for j in (0..@cols-1)
        neighbors = get_neighbors i, j

        if @grid[i][j] && ( neighbors < 2 || neighbors > 3 )
          new_grid[i][j] = false
        elsif @grid[i][j] && (neighbors == 2 || neighbors == 3)
          new_grid[i][j] = true
        elsif !@grid[i][j] && neighbors == 3
          new_grid[i][j] = true
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
      canvas.set(x, y) if x < @rows && y < @cols && @grid[x][y] == true
    end
    canvas
  end

  private

  def each_grid
    (0...@rows - 1).each do |y|
      (0...@cols - 1).each do |x|
        yield x, y
      end
    end
  end
end
