class ViewWinStatus
  def initialize(board_repository:)
    @board_repository = board_repository
  end

  def execute
    @board = @board_repository.fetch.to_a

    ranges_to_check.each do |range|
      pieces_in_range = pieces_in_range(range)
      return { status: winner(pieces_in_range) } if win?(pieces_in_range)
    end

    { status: :in_progress }
  end

  private

  def ranges_to_check
    [
      (0..3),
      (3..6),
      (6..10),
    ]
  end

  def pieces_in_range(range)
    range.map { |i| @board[i] }.compact
  end

  def winner(row)
    winning_piece = row[0]
    if winning_piece == 'X'
      :x_wins
    else
      :o_wins
    end
  end

  def win?(row)
    pieces_in_row = row.length
    unique_pieces_in_row = row.uniq.length
    pieces_in_row == 3 && unique_pieces_in_row == 1
  end
end
