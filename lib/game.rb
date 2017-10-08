class Game
  GRID_SIZE = 3

  def start(presenter)
    @presenter = presenter
    @board = empty_board

    present
  end

  def place(x, y)
    position = linear_position_for(x, y)
    @board[position] = 'X'

    present
  end

  private

  def present
    @presenter.present(@board)
    nil
  end

  def empty_board
    [
      '', '', '',
      '', '', '',
      '', '', ''
    ]
  end

  def linear_position_for(x, y)
    zero_indexed_y = y - 1
    zero_indexed_x = x - 1
    (zero_indexed_y * GRID_SIZE) + zero_indexed_x
  end
end
