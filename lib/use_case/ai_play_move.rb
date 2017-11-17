require 'minimax'

class AiPlayMove
  def initialize(board_repository:, play_move:, view_available_moves:)
    @play_move = play_move
    @board_repository = board_repository
    @view_available_moves = view_available_moves
  end

  def execute(type:)
    available_moves = @view_available_moves.execute
    board = @board_repository.fetch
    if (available_moves.length % board.size) == 0
      @play_move.execute(x: 1, y: 1, type: type)

      return {}
    end
    minimaxable_moves = available_moves.map do |x, y|
      Minimaxable.new(
        board: board, x: x, y: y, type: type, ai: type
      )
    end

    selected_move = Minimax.new.find_optimum_next_move(minimaxable_moves)

    @play_move.execute(x: selected_move[:x], y: selected_move[:y], type: type)

    {}
  end
end

class Minimaxable
  def initialize(board:, x:, y:, type:, ai:)
    @current_board = board
    @x = x
    @y = y
    @type = type
    @ai = ai
  end

  def score
    @board = with_piece_at(@x, @y, @type)
    status = check_win_status
    return 0 if status == :in_progress

    if status == :x_wins && @ai == 'X'
      10
    elsif status == :o_wins && @ai == 'O'
      10
    else
      -10
    end
  end

  def option
    { x: @x, y: @y }
  end

  def child_moves
    opp_type = @type == 'X' ? 'O' : 'X'
    @board ||= with_piece_at(@x, @y, @type)
    @board.all_remaining_moves.map do |x,y|
      Minimaxable.new(board: @board, x: x, y: y, type: opp_type, ai: @ai)
    end
  end

  def with_piece_at(x, y, piece)
    board = @current_board
    position = linear_position_for(x, y)

    new_state = board.to_a.dup
    new_state[position] = piece
    Board.new(
      size: board.size,
      initial_state: new_state
    )
  end

  def linear_position_for(x, y)
    board = @current_board
    zero_indexed_y = y - 1
    zero_indexed_x = x - 1
    (zero_indexed_y * board.size) + zero_indexed_x
  end


  def check_win_status
    ranges_to_check.each do |range|
      pieces_in_range = pieces_in_range(range)
      return winner(pieces_in_range) if win?(pieces_in_range)
    end

    :in_progress
  end

  private

  def ranges_to_check
    [
      (0..3),
      (3..6),
      (6..10),
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]
  end

  def pieces_in_range(range)
    range.map { |i| @board.to_a[i] }.compact
  end

  def winner(row)
    winning_piece = row[0]
    if winning_piece == 'X'
      :x_wins
    else
      :o_wins
    end
  end

  def win?(row)
    pieces_in_row = row.length
    unique_pieces_in_row = row.uniq.length
    pieces_in_row == 3 && unique_pieces_in_row == 1
  end
end
