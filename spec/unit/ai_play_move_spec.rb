require 'use_case/ai_play_move'

describe AiPlayMove do
  class PlayMoveSpy
    attr_reader :last_move

    def execute(request)
      @last_move = request
    end
  end
  let(:play_move_spy) { PlayMoveSpy.new }
  let(:use_case) do
    AiPlayMove.new(
      board_repository: double(fetch: board),
      play_move: play_move_spy
    )
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
end
