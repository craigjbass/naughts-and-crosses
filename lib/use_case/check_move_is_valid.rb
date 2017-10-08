class CheckMoveIsValid
  def initialize(view_available_moves:)
    @view_available_moves = view_available_moves
  end

  def execute(x:, y:)
    available_coordinates.include?([x, y])
  end

  private

  def available_coordinates
    @view_available_moves.execute
  end
end
