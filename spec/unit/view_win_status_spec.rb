require 'use_case/view_win_status'

describe ViewWinStatus do
  let(:board_repository) { double(fetch: Board.new(size: 3, initial_state: board)) }
  subject do
    ViewWinStatus.new(
      board_repository: board_repository
    ).execute
  end

  context 'given an empty board' do
    let(:board) do
      [
        nil, nil, nil,
        nil, nil, nil,
        nil, nil, nil
      ]
    end

    it 'is a game in progress' do
      is_expected.to eq(status: :in_progress)
    end
  end

  context 'given X in left' do
    let(:board) do
      [
        'X', nil, nil,
        nil, nil, nil,
        nil, nil, nil
      ]
    end

    it 'is a game in progress' do
      is_expected.to eq(status: :in_progress)
    end
  end

  context 'given X in top two left' do
    let(:board) do
      [
        'X', 'X', nil,
        nil, nil, nil,
        nil, nil, nil
      ]
    end

    it 'is a game in progress' do
      is_expected.to eq(status: :in_progress)
    end
  end

  context 'given top horizontal X win' do
    let(:board) do
      [
        'X', 'X', 'X',
        nil, nil, nil,
        nil, nil, nil
      ]
    end

    it 'is win for x' do
      is_expected.to eq(status: :x_wins)
    end
  end

  context 'given middle horizontal X win' do
    let(:board) do
      [
        nil, nil, nil,
        'X', 'X', 'X',
        nil, nil, nil
      ]
    end

    it 'is win for x' do
      is_expected.to eq(status: :x_wins)
    end
  end

  context 'given bottom horizontal X win' do
    let(:board) do
      [
        nil, nil, nil,
        nil, nil, nil,
        'X', 'X', 'X'
      ]
    end

    it 'is win for x' do
      is_expected.to eq(status: :x_wins)
    end
  end
end
