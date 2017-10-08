class AiPlayMove
  def initialize(board_repository:, play_move:)
    @play_move = play_move
    @board_repository = board_repository
  end

  def execute(type:)
    @play_move.execute(x: 2, y: 2, type: type)
  end
end
