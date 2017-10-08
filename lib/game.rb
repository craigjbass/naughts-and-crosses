require 'domain/board'
require 'board_repository'
require 'use_case/start_game'
require 'use_case/play_move'
require 'use_case/view_available_moves'
require 'use_case/check_move_is_valid'

class Game
  BOARD_SIZE = 3

  def initialize
    @board_repository = BoardRepository.new
    @start_game = StartGame.new(board_repository: @board_repository)
    @place_new_piece = PlayMove.new(board_repository: @board_repository)
    @view_available_moves = ViewAvailableMoves.new(board_repository: @board_repository)
    @check_move_is_valid = CheckMoveIsValid.new(view_available_moves: @view_available_moves)
  end

  def start(presenter)
    @presenter = presenter
    @start_game.execute(size: BOARD_SIZE)

    present
  end

  def valid?(x, y)
    @check_move_is_valid.execute(x: x, y: y)
  end

  def place(x, y)
    @place_new_piece.execute(x: x, y: y, type: 'X')
    present
  end

  def available_coordinates
    @view_available_moves.execute
  end

  private

  def present
    board = @board_repository.fetch.to_a
    @presenter.present(
      board.map { |cell| cell.nil? ? '' : cell }
    )
    nil
  end
end
