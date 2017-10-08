class ImmutableBoard
  def initialize(size:, initial_state: empty_board)
    @state = initial_state.freeze
    @size = size
  end

  def to_a
    @state
  end

  def place(piece, x, y)
    position = linear_position_for(x, y)

    new_state = @state.dup
    new_state[position] = piece
    ImmutableBoard.new(
      size: @size,
      initial_state: new_state
    )
  end

  def occupied_coordinates
    occupied_linear_positions.map do |linear_position|
      xy_coordinate_for(linear_position)
    end
  end

  def coordinates
    (1...@size + 1)
      .to_a
      .repeated_permutation(2)
      .to_a
  end

  private

  def empty_board
    [
      '', '', '',
      '', '', '',
      '', '', ''
    ]
  end

  def occupied_linear_positions
    @state
      .each_index
      .select { |i| @state[i] == 'X' }
  end

  def xy_coordinate_for(linear_position)
    [linear_position % @size + 1, linear_position / @size + 1]
  end

  def linear_position_for(x, y)
    zero_indexed_y = y - 1
    zero_indexed_x = x - 1
    (zero_indexed_y * @size) + zero_indexed_x
  end
end
