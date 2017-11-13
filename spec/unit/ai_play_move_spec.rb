require 'use_case/ai_play_move'
require 'domain/board'
require 'use_case/view_available_moves'

describe AiPlayMove do
  class PlayMoveSpy
    attr_reader :last_move

    def execute(request)
      @last_move = request
    end
  end
  let(:play_move_spy) { PlayMoveSpy.new }
  let(:use_case) do
    board_repository = double(fetch: board)
    view_available_moves = ViewAvailableMoves.new(board_repository)

    AiPlayMove.new(
      board_repository: board_repository,
      play_move: play_move_spy,
      view_available_moves: view_available_moves
    )
  end

  context 'given board is size 3' do
    let(:size) { 3 }

    context 'and AI plays as O' do
      before { use_case.execute(type: 'O') }

      context 'and it has one move remaining' do
        let(:board) do
          Board.new(
            size: size,
            initial_state: [
              'X', 'X', 'O',
              'O', 'X', 'O',
              'X', 'O', nil
            ]
          )
        end

        it 'chooses the remaining space' do
          expect(play_move_spy.last_move).to eq(x: 3, y: 3, type: 'O')
        end
      end
    end
  end

  context 'given an empty board of size 3' do
    let(:size) { 3 }
    let(:board) do
      Board.new(
        size: size,
        initial_state: (0...size * size).map { |_| nil }
      )
    end

    context 'when the ai plays a move as O' do
      before { use_case.execute(type: 'O') }
      it 'places a piece in the middle' do
        expect(play_move_spy.last_move).to eq(x: 2, y: 2, type: 'O')
      end
    end

    context 'when the ai plays a move as X' do
      before { use_case.execute(type: 'X') }

      it 'places a piece in the middle' do
        expect(play_move_spy.last_move).to eq(x: 2, y: 2, type: 'X')
      end
    end
  end

  context 'given a board with multiple remaining spaces' do
    let(:size) { 3 }
    let(:board) do
      Board.new(
        size: size,
        initial_state: [
          'X', 'X', nil,
          'O', 'X', 'O',
          nil, 'O', 'O'
        ]
      )
    end

    context 'when the ai plays a move as X' do
    end
  end
end
