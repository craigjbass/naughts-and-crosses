class BoardCoordinates
  def initialize(size:)
    @size = size
  end

  def occupied_coordinates(board)
    board.occupied_linear_positions.map do |linear_position|
      xy_coordinate_for(linear_position)
    end
  end

  def xy_coordinate_for(linear_position)
    [linear_position % @size + 1, linear_position / @size + 1]
  end

  def all_possible_coordinates
    (1...@size + 1)
      .to_a
      .repeated_permutation(2)
      .to_a
  end
end
