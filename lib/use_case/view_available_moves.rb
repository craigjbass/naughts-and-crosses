class ViewAvailableMoves
  def initialize(board_repository)
    @board_repository = board_repository
  end

  def execute
    @board = @board_repository.fetch
    @board.all_remaining_moves
  end
end
