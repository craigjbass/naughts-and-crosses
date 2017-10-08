shared_examples 'a board repository' do
  context 'given no board has been initialised' do
    it 'should contain no board' do
      expect(subject.fetch).to eq(nil)
    end
  end

  context 'given a board has been saved' do
    before { subject.update(this: 'is a fake board') }
    it 'should contain a board' do
      expect(subject.fetch).to eq(this: 'is a fake board')
    end

    context 'and another new board has been saved' do
      before { subject.update(this: 'is another fake board') }

      it 'should contain the newer board' do
        expect(subject.fetch).to eq(this: 'is another fake board')
      end
    end
  end
end

describe InMemoryBoardRepository do
  subject { InMemoryBoardRepository.new }

  it_behaves_like 'a board repository'
end

describe SubscribableBoardRepositoryProxy do
  subject do
    SubscribableBoardRepositoryProxy.new(
      InMemoryBoardRepository.new
    )
  end

  it_behaves_like 'a board repository'

  context 'given a subscriber has subscribed' do
    it 'calls the subscriber when update is called' do
      subscriber_called = false
      subject.subscribe { subscriber_called = true }
      subject.update(nil)

      expect(subscriber_called).to eq(true)
    end
  end
end
