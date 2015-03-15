describe Bumbleworks::Api::TaskPresenter do
  let(:process) { Bumbleworks.launch!('task_process') }
  let(:presented) { process.tasks.next_available }
  subject { described_class.new(presented) }

  describe "#to_hash" do
    it "returns hash representation of entity class" do
      presented.claim('oscar')
      expect(subject.to_hash).to eq({
        :id => presented.id,
        :name => presented.to_s,
        :claimant => 'oscar',
        :process_id => presented.wfid,
        :role => presented.role
      })
    end
  end
end