class Board
  attr_reader :size

  def initialize(size:, initial_state: nil)
    @size = size
    @state = initial_state.freeze
  end

  def to_a
    @state
  end

  def all_remaining_moves
    all_possible_coordinates - occupied_coordinates
  end

  private

  def all_possible_coordinates
    (1...size + 1)
      .to_a
      .repeated_permutation(2)
      .to_a
  end

  def occupied_coordinates
    occupied_linear_positions.map do |linear_position|
      xy_coordinate_for(linear_position)
    end
  end

  def xy_coordinate_for(linear_position)
    [linear_position % size + 1, linear_position / size + 1]
  end

  def occupied_linear_positions
    @state
      .each_index
      .select { |i| @state[i] == 'X' }
  end
end
