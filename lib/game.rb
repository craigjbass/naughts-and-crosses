require 'immutable_board'
require 'board_creator'
require 'board_coordinates'

class Game
  BOARD_SIZE = 3

  def start(presenter)
    @presenter = presenter
    @board = ImmutableBoard.new(size: BOARD_SIZE)
    @board_coordinates = BoardCoordinates.new(size: BOARD_SIZE)
    @board_creator = BoardCreator.new(size: BOARD_SIZE)

    present
  end

  def valid?(x, y)
    available_coordinates.include?([x, y])
  end

  def place(x, y)
    @board = @board_creator.with_piece_at(@board, x, y, 'X')

    present
  end

  def available_coordinates
    all_possible_coordinates - occupied_coordinates
  end

  private

  def present
    board = @board.to_a
    @presenter.present(
      board.map { |cell| cell.nil? ? '' : cell }
    )
    nil
  end

  def occupied_coordinates
    @board_coordinates.occupied_coordinates(@board)
  end

  def all_possible_coordinates
    @board_coordinates.all_possible_coordinates
  end
end
