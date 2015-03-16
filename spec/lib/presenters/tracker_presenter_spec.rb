describe Bumbleworks::Api::TrackerPresenter do
  let(:process) { Bumbleworks.launch!('waiting_process') }
  let(:presented) { Bumbleworks::Tracker.all.first }
  subject { described_class.new(presented) }

  describe "#to_hash" do
    it "returns hash representation of entity class" do
      expect(subject.to_hash).to eq({
        :id => presented.id,
        :waiting_expression => presented.waiting_expression,
        :original_hash => presented.original_hash,
        :action => presented.action,
        :conditions => presented.conditions,
        :process_id => presented.wfid
      })
    end
  end
end