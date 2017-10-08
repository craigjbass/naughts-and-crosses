class PlayMove
  def initialize(board_repository:)
    @board_repository = board_repository
  end

  def execute(x:, y:, type:)
    @board_repository.update(
      with_piece_at(x, y, type)
    )
  end

  private

  def with_piece_at(x, y, piece)
    board = @board_repository.fetch
    position = linear_position_for(x, y)

    new_state = board.to_a.dup
    new_state[position] = piece
    ImmutableBoard.new(
      size: board.size,
      initial_state: new_state
    )
  end

  def linear_position_for(x, y)
    board = @board_repository.fetch
    zero_indexed_y = y - 1
    zero_indexed_x = x - 1
    (zero_indexed_y * board.size) + zero_indexed_x
  end
end
