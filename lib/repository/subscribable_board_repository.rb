class SubscribableBoardRepository
  def initialize(board_repository)
    @board_repository = board_repository
  end

  def fetch
    @board_repository.fetch
  end

  def update(new_board)
    @board_repository.update(new_board)
    @subscriber.()
  end

  def subscribe(&block)
    @subscriber = block
  end
end
