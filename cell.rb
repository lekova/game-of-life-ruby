require 'pry'

class Cell
  attr_accessor :is_alive

  def initialize is_alive
    @is_alive = is_alive
  end

  def set_random
    Random.rand(2) == 1 ? @is_alive = true : @is_alive = false
  end
end
