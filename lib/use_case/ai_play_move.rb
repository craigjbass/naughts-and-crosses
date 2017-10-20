class AiPlayMove
  def initialize(board_repository:, play_move:, view_available_moves:)
    @play_move = play_move
    @board_repository = board_repository
    @view_available_moves = view_available_moves
  end

  def execute(type:)

    available_moves = @view_available_moves.execute
    if available_moves.length == 1
      @play_move.execute(x: 3, y: 3, type: type)
      return
    end

    @play_move.execute(x: 2, y: 2, type: type)
  end
end
