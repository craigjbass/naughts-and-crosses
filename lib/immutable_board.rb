class ImmutableBoard
  attr_reader :size

  def initialize(size:, initial_state: nil)
    @size = size
    @state = (initial_state || empty_board_with).freeze
  end

  def occupied_linear_positions
    @state
      .each_index
      .select { |i| @state[i] == 'X' }
  end

  def to_a
    @state
  end

  private

end
