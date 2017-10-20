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

  context 'given X and Os fill horizontal' do
    let(:board) do
      [
        'X', 'O', 'X',
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

  context 'given a winning board' do
    let(:winning_boards) do
      [
        [
          :!, :!, :!,
          nil, nil, nil,
          nil, nil, nil
        ],
        [
          nil, nil, nil,
          :!, :!, :!,
          nil, nil, nil
        ],
        [
          nil, nil, nil,
          nil, nil, nil,
          :!, :!, :!
        ],
        [
          :!, nil, nil,
          :!, nil, nil,
          :!, nil, nil
        ],
        [
          nil, :!, nil,
          nil, :!, nil,
          nil, :!, nil
        ],
        [
          nil, nil, :!,
          nil, nil, :!,
          nil, nil, :!
        ],
        [
          :!, nil, nil,
          nil, :!, nil,
          nil, nil, :!
        ],
        [
          nil, nil, :!,
          nil, :!, nil,
          :!, nil, nil
        ]
      ]
    end

    def test_winning_boards(piece, expectation)
      winning_boards.each do |board|
        board = Board.new(size: 3, initial_state: board.map { |cell| cell.nil? ? nil : piece })
        board_repository = double(fetch: board)
        win_status = ViewWinStatus.new(board_repository: board_repository).execute
        expect(win_status).to eq(expectation)
      end
    end

    it 'detects wins for X' do
      test_winning_boards('X', status: :x_wins)
    end

    it 'detects wins for O' do
      test_winning_boards('O', status: :o_wins)
    end
  end
end
