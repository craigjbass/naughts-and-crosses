require 'immutable_board'
require 'board_creator'
require 'board_coordinates'
require 'board_repository'

class Game
  BOARD_SIZE = 3

  def initialize
    @board_repository = BoardRepository.new
  end

  def start(presenter)
    @presenter = presenter
    @board_creator = BoardCreator.new(board_repository: @board_repository)
    @board_repository.update(@board_creator.empty_board(size: BOARD_SIZE))
    @board_coordinates = BoardCoordinates.new(size: BOARD_SIZE)

    present
  end

  def valid?(x, y)
    available_coordinates.include?([x, y])
  end

  def place(x, y)
    @board_repository.update(
      @board_creator.with_piece_at(x, y, 'X')
    )

    present
  end

  def available_coordinates
    all_possible_coordinates - occupied_coordinates
  end

  private

  def present
    board = @board_repository.fetch.to_a
    @presenter.present(
      board.map { |cell| cell.nil? ? '' : cell }
    )
    nil
  end

  def occupied_coordinates
    @board_coordinates.occupied_coordinates(@board_repository.fetch)
  end

  def all_possible_coordinates
    @board_coordinates.all_possible_coordinates
  end
end
