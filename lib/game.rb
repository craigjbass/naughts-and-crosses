require 'board'

class Game
  def start(presenter)
    @presenter = presenter
    @board = Board.new(size: 3)

    present
  end

  def place(x, y)
    position = @board.linear_position_for(x, y)
    @board[position] = 'X'

    present
  end

  def available_coordinates
    occupied_coordinates = @board.occupied_xy_coordinates

    @board.grid_coordinates.reject { |c| occupied_coordinates.include?(c) }
  end

  private

  def present
    @presenter.present(@board.to_a)
    nil
  end
end
