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

  def available_coordinates
    one_dimension_of_coordinates = (1...GRID_SIZE + 1).to_a
    all_grid_coordinates = one_dimension_of_coordinates
                             .repeated_permutation(2)
                             .to_a

    return all_grid_coordinates.reject { |c| c == [1,1] } if @board[0] == 'X'
    return all_grid_coordinates.reject { |c| c == [1,2] } if @board[3] == 'X'
    return all_grid_coordinates.reject { |c| c == [3,2] } if @board[5] == 'X'
    return all_grid_coordinates.reject { |c| c == [2,2] } if @board[4] == 'X'
    return all_grid_coordinates.reject { |c| c == [1,3] } if @board[6] == 'X'

    all_grid_coordinates
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
