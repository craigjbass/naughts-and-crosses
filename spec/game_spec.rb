require 'game'

describe Game do
  class PresenterSpy
    attr_reader :board

    def present(board)
      @board = board
    end
  end

  let(:game) { Game.new }
  let(:presenter) { PresenterSpy.new }

  context 'given the game has started' do
    before { game.start(presenter) }

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
        expect(game.place(1, 1)).to be_nil
      end

      it 'has all positions as available' do
        [
          [1, 1],
          [2, 1],
          [3, 1],
          [1, 2],
          [2, 2],
          [3, 2],
          [1, 3],
          [2, 3],
          [3, 3]
        ].each do |coordinate|
          expect(game.available_coordinates).to include(coordinate)
        end
      end
    end

    context 'when the player has placed a piece' do
      before { game.place(x, y) }

      context 'in position 1,1' do
        let(:x) { 1 }
        let(:y) { 1 }
        it 'presents the players piece' do
          expected_board = [
            'X', '', '',
            '', '', '',
            '', '', ''
          ]
          expect(presenter.board).to eq(expected_board)
        end

        it 'has not got 1,1 available' do
          expect(game.available_coordinates).not_to include([1, 1])
        end

        it 'has all other coordinates available' do
          [
            [2, 1],
            [3, 1],
            [1, 2],
            [2, 2],
            [3, 2],
            [1, 3],
            [2, 3],
            [3, 3]
          ].each do |coordinate|
            expect(game.available_coordinates).to include(coordinate)
          end
        end
      end

      context 'in position 1,2' do
        let(:x) { 1 }
        let(:y) { 2 }
        it 'presents the players piece' do
          expected_board = [
            '', '', '',
            'X', '', '',
            '', '', ''
          ]
          expect(presenter.board).to eq(expected_board)
        end

        it 'has not got 1,2 available' do
          expect(game.available_coordinates).not_to include([1, 2])
        end
      end


      context 'in position 3,2' do
        let(:x) { 3 }
        let(:y) { 2 }
        it 'presents the players piece' do
          expected_board = [
            '', '', '',
            '', '', 'X',
            '', '', ''
          ]
          expect(presenter.board).to eq(expected_board)
        end

        it 'has not got 3,2 available' do
          expect(game.available_coordinates).not_to include([3, 2])
        end
      end

      context 'in position 2,2' do
        let(:x) { 2 }
        let(:y) { 2 }
        it 'presents the players piece' do
          expected_board = [
            '', '', '',
            '', 'X', '',
            '', '', ''
          ]
          expect(presenter.board).to eq(expected_board)
        end

        it 'has not got 2,2 available' do
          expect(game.available_coordinates).not_to include([2, 2])
        end
      end

      context 'in position 1,3' do
        let(:x) { 1 }
        let(:y) { 3 }
        it 'presents the players piece' do
          expected_board = [
            '', '', '',
            '', '', '',
            'X', '', ''
          ]
          expect(presenter.board).to eq(expected_board)
        end

        it 'has not got 1,3 available' do
          expect(game.available_coordinates).not_to include([1, 3])
        end
      end
    end
  end
end
