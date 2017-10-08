class ViewBoard
  def initialize(board_repository)
    @board_repository = board_repository
  end

  def execute(presenter)
    board = @board_repository.fetch.to_a
    presenter.present(
      board.map { |cell| cell.nil? ? '' : cell }
    )
  end
end
