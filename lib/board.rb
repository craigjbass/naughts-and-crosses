class Board
  def initialize(size:)
    @array = empty_board
    @size = size
  end

  def empty_board
    [
      '', '', '',
      '', '', '',
      '', '', ''
    ]
  end

  def []=(key, value)
    @array[key] = value
  end

  def [](key)
    @array[key]
  end

  def occupied_linear_positions
    @array
      .each_index
      .select { |i| @array[i] == 'X' }
  end

  def occupied_xy_coordinates
    occupied_linear_positions.map do |linear_position|
      xy_coordinate_for(linear_position)
    end
  end

  def grid_coordinates
    (1...@size + 1)
      .to_a
      .repeated_permutation(2)
      .to_a
  end

  def xy_coordinate_for(linear_position)
    [linear_position % @size + 1, linear_position / @size + 1]
  end

  def linear_position_for(x, y)
    zero_indexed_y = y - 1
    zero_indexed_x = x - 1
    (zero_indexed_y * @size) + zero_indexed_x
  end

  def to_a
    @array
  end
end
