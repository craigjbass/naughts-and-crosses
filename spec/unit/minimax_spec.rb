require 'minimax'

describe Minimax do
  class MinimaxableStub
    attr_reader :option, :score, :child_moves

    def initialize(option:, score:, children: [])
      @option = option
      @score = score
      @child_moves = children
    end
  end

  subject { Minimax.new }
  let(:optimum_move) { subject.find_optimum_next_move(possibilities) }

  context 'given no possibilities' do
    let(:possibilities) { [] }
    it('gives nil') { expect(optimum_move).to eq(nil) }
  end

  context 'given one leaf possibility' do
    let(:possibilities) { [MinimaxableStub.new(option: { option: 1 }, score: 0)] }
    it 'gives leaf possibility' do
      expect(optimum_move).to eq(option: 1)
    end
  end

  context 'given two leaf possibilities' do
    context do
      let(:possibilities) do
        [
          MinimaxableStub.new(option: [1, 2, 'X'], score: 0),
          MinimaxableStub.new(option: [2, 2, 'X'], score: 10)
        ]
      end
      it 'chooses possibility with highest score' do
        expect(optimum_move).to eq([2, 2, 'X'])
      end
    end

    context do
      let(:possibilities) do
        [
          MinimaxableStub.new(option: [1, 2, 'X'], score: 10),
          MinimaxableStub.new(option: [2, 2, 'X'], score: 0)
        ]
      end
      it 'chooses possibility with highest score' do
        expect(optimum_move).to eq([1, 2, 'X'])
      end
    end
  end

  context 'given one root, with one leaf possibilty' do
    let(:possibilities) do
      [
        MinimaxableStub.new(
          option: [1, 2, 'X'],
          score: 0,
          children: [
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: 0
            )
          ]
        )
      ]
    end
    it 'chooses leaf root possibility' do
      expect(optimum_move).to eq([1, 2, 'X'])
    end
  end

  context 'given two root, one with one deep possibility' do
    let(:possibilities) do
      [
        MinimaxableStub.new(
          option: [1, 2, 'X'],
          score: 0,
          children: [
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: 0
            )
          ]
        ),
        MinimaxableStub.new(
          option: [3, 2, 'X'],
          score: 10
        )
      ]
    end
    it 'chooses highest leaf root possibility' do
      expect(optimum_move).to eq([3, 2, 'X'])
    end
  end

  context 'given two root, one with one deep possibility' do
    let(:possibilities) do
      [
        MinimaxableStub.new(
          option: [1, 2, 'X'],
          score: 10,
          children: [
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: -10
            )
          ]
        ),
        MinimaxableStub.new(
          option: [3, 2, 'X'],
          score: 0
        )
      ]
    end
    it 'chooses highest scored root possibility' do
      expect(optimum_move).to eq([3, 2, 'X'])
    end
  end

  context 'given two root, both with 2x one deep possibility' do
    let(:possibilities) do
      [
        MinimaxableStub.new(
          option: [1, 2, 'X'],
          score: 0,
          children: [
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: 0
            ),
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: 10
            )
          ]
        ),
        MinimaxableStub.new(
          option: [3, 2, 'X'],
          score: 0,
          children: [
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: 0
            ),
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: -10
            )
          ]
        )
      ]
    end
    it 'chooses highest scored root possibility' do
      expect(optimum_move).to eq([1, 2, 'X'])
    end
  end

  context 'given two root, both with 2x two deep possibility' do
    let(:possibilities) do
      [
        MinimaxableStub.new(
          option: [1, 2, 'X'],
          score: 0,
          children: [
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: 0,
              children: [
                MinimaxableStub.new(
                  option: [1, 3, 'O'],
                  score: 0
                ),
                MinimaxableStub.new(
                  option: [1, 3, 'O'],
                  score: -10
                )
              ]
            ),
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: 10,
              children: [
                MinimaxableStub.new(
                  option: [1, 3, 'O'],
                  score: 0
                ),
                MinimaxableStub.new(
                  option: [1, 3, 'O'],
                  score: 0
                )
              ]
            )
          ]
        ),
        MinimaxableStub.new(
          option: [3, 2, 'X'],
          score: 0,
          children: [
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: 0,
              children: [
                MinimaxableStub.new(
                  option: [1, 3, 'O'],
                  score: 0
                ),
                MinimaxableStub.new(
                  option: [1, 3, 'O'],
                  score: 0
                )
              ]
            ),
            MinimaxableStub.new(
              option: [1, 3, 'O'],
              score: 0,
              children: [
                MinimaxableStub.new(
                  option: [1, 3, 'O'],
                  score: 10
                ),
                MinimaxableStub.new(
                  option: [1, 3, 'O'],
                  score: 10
                )
              ]
            )
          ]
        )
      ]
    end
    it 'chooses highest scored root possibility' do
      expect(optimum_move).to eq([3, 2, 'X'])
    end
  end
end
