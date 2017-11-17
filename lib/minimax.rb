require 'parallel'

class Minimax
  def find_optimum_next_move(moves)
    return nil if moves.empty?

    Parallel.map(moves) { |move| score_move(move) }
      .sort_by { |a| a[:score] }
      .last[:option]
  end

  private

  def score_move(move)
    children_scores = sum_of_scores(move.child_moves)
    {
      score: move.score + children_scores,
      option: move.option
    }
  end

  def sum_of_scores(moves)
    return 0 if moves.empty?
    moves.map do |child|
      child.score + sum_of_scores(child.child_moves)
    end.inject(:+)
  end
end
