require 'board'

class Game
  def start(presenter)
    @presenter = presenter
    @board = Board.new(size: 3)

    present
  end

  def place(x, y)
    @board.place('X', x, y)

    present
  end

  def available_coordinates
    occupied_coordinates = @board.occupied_coordinates
    @board.coordinates.reject do |coordinate|
      occupied_coordinates.include?(coordinate)
    end
  end

  private

  def present
    @presenter.present(@board.to_a)
    nil
  end
end
