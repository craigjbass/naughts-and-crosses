class CheckMoveIsValid
  def initialize(board_repository:)
    @board_repository = board_repository
  end

  def execute(x:, y:)
    @board = @board_repository.fetch
    @board.all_remaining_moves.include?([x, y])
  end
end
