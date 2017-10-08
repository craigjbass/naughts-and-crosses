class BoardCreator
  def initialize(size:)
    @size = size
  end

  def with_piece_at(board, x, y, piece)
    position = linear_position_for(x, y)

    new_state = board.to_a.dup
    new_state[position] = piece
    ImmutableBoard.new(
      size: @size,
      initial_state: new_state
    )
  end

  def linear_position_for(x, y)
    zero_indexed_y = y - 1
    zero_indexed_x = x - 1
    (zero_indexed_y * @size) + zero_indexed_x
  end

  def empty_board(size:)
    ImmutableBoard.new(size: size)
  end
end
