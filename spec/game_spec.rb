class Game
  GRID_SIZE = 3

  def start(presenter)
    @presenter = presenter
    @board = empty_board

    present
  end

  def place(x, y)
    position = linear_position_for(x, y)
    @board[position] = 'X'

    present
  end

  private

  def present
    @presenter.present(@board)
    nil
  end

  def empty_board
    [
      '', '', '',
      '', '', '',
      '', '', ''
    ]
  end

  def linear_position_for(x, y)
    zero_indexed_y = y - 1
    zero_indexed_x = x - 1
    (zero_indexed_y * GRID_SIZE) + zero_indexed_x
  end
end


describe Game do
  class PresenterSpy
    attr_reader :board

    def present(board)
      @board = board
    end
  end

  let(:game) {Game.new}
  let(:presenter) {PresenterSpy.new}

  context 'given the game has started' do
    before {game.start(presenter)}

    context 'given nobody has made any moves' do
      it 'presents an empty board' do
        expected_board = [
          '', '', '',
          '', '', '',
          '', '', ''
        ]
        expect(presenter.board).to eq(expected_board)
      end

      it '#place has nil return value' do
        expect(game.place(1,1)).to be_nil
      end
    end

    context 'when the player has placed a piece' do
      before {game.place(x, y)}

      context 'in position 1,1' do
        let(:x) {1}
        let(:y) {1}
        it 'presents the players piece' do
          expected_board = [
            'X', '', '',
            '', '', '',
            '', '', ''
          ]
          expect(presenter.board).to eq(expected_board)
        end
      end

      context 'in position 1,2' do
        let(:x) {1}
        let(:y) {2}
        it 'presents the players piece' do
          expected_board = [
            '', '', '',
            'X', '', '',
            '', '', ''
          ]
          expect(presenter.board).to eq(expected_board)
        end
      end


      context 'in position 3,2' do
        let(:x) {3}
        let(:y) {2}
        it 'presents the players piece' do
          expected_board = [
            '', '', '',
            '', '', 'X',
            '', '', ''
          ]
          expect(presenter.board).to eq(expected_board)
        end
      end

      context 'in position 2,2' do
        let(:x) {2}
        let(:y) {2}
        it 'presents the players piece' do
          expected_board = [
            '', '', '',
            '', 'X', '',
            '', '', ''
          ]
          expect(presenter.board).to eq(expected_board)
        end
      end

      context 'in position 1,3' do
        let(:x) {1}
        let(:y) {3}
        it 'presents the players piece' do
          expected_board = [
            '', '', '',
            '', '', '',
            'X', '', ''
          ]
          expect(presenter.board).to eq(expected_board)
        end
      end
    end
  end
end
