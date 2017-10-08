require 'domain/board'
require 'repository/in_memory_board_repository'
require 'repository/subscribable_board_repository_proxy'
require 'use_case/start_game'
require 'use_case/play_move'
require 'use_case/view_available_moves'
require 'use_case/check_move_is_valid'
require 'use_case/view_board'

class Game
  BOARD_SIZE = 3

  def initialize
    @board_repository = SubscribableBoardRepositoryProxy.new(InMemoryBoardRepository.new)

    @start_game = StartGame.new(@board_repository)
    @place_new_piece = PlayMove.new(@board_repository)
    @view_available_moves = ViewAvailableMoves.new(@board_repository)
    @check_move_is_valid = CheckMoveIsValid.new(@board_repository)
    @view_board = ViewBoard.new(@board_repository)
  end

  def start(presenter)
    subscribe_presenter_to_updates(presenter)
    @start_game.execute(size: BOARD_SIZE)
  end

  def valid?(x, y)
    @check_move_is_valid.execute(x: x, y: y)
  end

  def place(x, y)
    @place_new_piece.execute(x: x, y: y, type: 'X')
  end

  def available_coordinates
    @view_available_moves.execute
  end

  private

  def subscribe_presenter_to_updates(presenter)
    @board_repository.subscribe do
      @view_board.execute(presenter)
    end
  end
end
