class ViewAvailableMoves
  def initialize(board_repository:)
    @board_repository = board_repository
  end

  def execute
    @board = @board_repository.fetch
    all_possible_coordinates - occupied_coordinates
  end

  private

  def occupied_coordinates
    @board.occupied_linear_positions.map do |linear_position|
      xy_coordinate_for(linear_position)
    end
  end

  def xy_coordinate_for(linear_position)
    [linear_position % @board.size + 1, linear_position / @board.size + 1]
  end

  def all_possible_coordinates
    (1...@board.size + 1)
      .to_a
      .repeated_permutation(2)
      .to_a
  end
end
