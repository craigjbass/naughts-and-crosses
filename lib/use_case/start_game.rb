class StartGame
  def initialize(board_repository:)
    @board_repository = board_repository
  end

  def execute(size:)
    @board_repository.update(
      empty_board_with(size)
    )
  end

  private

  def empty_board_with(size)
    Board.new(
      size: size,
      initial_state: (0...size * size).map { |_| nil }
    )
  end
end
