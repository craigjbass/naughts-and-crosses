class ViewWinStatus
  def initialize(board_repository:)
    @board_repository = board_repository
  end

  def execute
    board = @board_repository.fetch.to_a
    if top_horizontal_win?(board) || middle_horizontal_win?(board) || bottom_horizontal_win?(board)
      { status: :x_wins }
    else
      { status: :in_progress }
    end
  end

  def top_horizontal_win?(board)
    s = (0..3).map { |i| board[i] }.compact
    s.length == 3
  end

  def middle_horizontal_win?(board)
    s = (3..6).map { |i| board[i] }.compact
    s.length == 3
  end

  def bottom_horizontal_win?(board)
    s = (6..10).map { |i| board[i] }.compact
    s.length == 3
  end
end
