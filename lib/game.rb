require 'board'

class Game
  GRID_SIZE = 3

  def start(presenter)
    @presenter = presenter
    @board = Board.new(empty_board)

    present
  end

  def place(x, y)
    position = linear_position_for(x, y)
    @board[position] = 'X'

    present
  end

  def available_coordinates
    occupied_coordinates = occupied_xy_coordinates

    grid_coordinates.reject { |c| occupied_coordinates.include?(c) }
  end

  private

  def present
    @presenter.present(@board.to_a)
    nil
  end

  def empty_board
    [
      '', '', '',
      '', '', '',
      '', '', ''
    ]
  end

  def occupied_xy_coordinates
    @board.occupied_linear_positions.map do |linear_position|
      xy_coordinate_for(linear_position)
    end
  end

  def grid_coordinates
    (1...GRID_SIZE + 1)
      .to_a
      .repeated_permutation(2)
      .to_a
  end

  def xy_coordinate_for(linear_position)
    [linear_position%GRID_SIZE+1, linear_position/GRID_SIZE+1]
  end

  def linear_position_for(x, y)
    zero_indexed_y = y - 1
    zero_indexed_x = x - 1
    (zero_indexed_y * GRID_SIZE) + zero_indexed_x
  end
end
