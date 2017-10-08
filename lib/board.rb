class Board
  def initialize
    @array = empty_board
  end

  def empty_board
    [
      '', '', '',
      '', '', '',
      '', '', ''
    ]
  end

  def []=(key, value)
    @array[key] = value
  end

  def [](key)
    @array[key]
  end

  def occupied_linear_positions
    @array
      .each_index
      .select { |i| @array[i] == 'X' }
  end

  def to_a
    @array
  end
end
