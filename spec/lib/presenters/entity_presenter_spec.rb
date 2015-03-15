describe Bumbleworks::Api::EntityPresenter do
  let(:presented) { Widget.new(42) }
  subject { described_class.new(presented) }

  describe "#to_hash" do
    it "returns hash representation of entity class" do
      allow(presented).to receive(:processes).and_return([:a, :b])
      expect(subject.to_hash).to eq({
        :identifier => 42,
        :name => "Widget 42",
        :process_count => 2
      })
    end
  end
end