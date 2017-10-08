require 'immutable_board'
require 'board_coordinates'
require 'board_repository'
require 'use_case/start_game'
require 'use_case/place_new_piece'

class Game
  BOARD_SIZE = 3

  def initialize
    @board_repository = BoardRepository.new
    @start_game = StartGame.new(board_repository: @board_repository)
    @place_new_piece = PlaceNewPiece.new(board_repository: @board_repository)
  end

  def start(presenter)
    @presenter = presenter
    @start_game.execute(size: BOARD_SIZE)
    @board_coordinates = BoardCoordinates.new(size: BOARD_SIZE)

    present
  end

  def valid?(x, y)
    available_coordinates.include?([x, y])
  end

  def place(x, y)
    @place_new_piece.execute(x: x, y: y, type: 'X')
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
