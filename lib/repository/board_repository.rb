class BoardRepository
  def fetch
    @current_board
  end

  def update(new_board)
    @current_board = new_board
  end
end
