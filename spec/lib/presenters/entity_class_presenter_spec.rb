describe Bumbleworks::Api::EntityClassPresenter do
  let(:presented) { Widget }
  subject { described_class.new(presented) }

  describe "#to_hash" do
    it "returns hash representation of entity class" do
      allow(presented).to receive(:count).and_return(10)
      expect(subject.to_hash).to eq({
        :class => 'Widget',
        :count => 10,
        :registered_processes => [
          { :name => :task_process, :attribute => :task_process_identifier }
        ]
      })
    end
  end
end