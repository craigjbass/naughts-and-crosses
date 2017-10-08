require 'board'

class Game
  def start(presenter)
    @presenter = presenter
    @board = Board.new(size: 3)

    present
  end

  def valid?(x, y)
    available_coordinates.include?([x, y])
  end

  def place(x, y)
    @board.place('X', x, y)

    present
  end

  def available_coordinates
    @board.coordinates - @board.occupied_coordinates
  end

  private

  def present
    @presenter.present(@board.to_a)
    nil
  end
end
