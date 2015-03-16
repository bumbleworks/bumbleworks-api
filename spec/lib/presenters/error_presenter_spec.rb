describe Bumbleworks::Api::ErrorPresenter do
  let(:presented) { Bumbleworks.errors.first }
  subject { described_class.new(presented) }

  describe "#to_hash" do
    it "returns hash representation of error" do
      process = Bumbleworks.launch!('error_process')
      wait_until { Bumbleworks.errors.count == 1 }
      expect(subject.to_hash).to eq({
        :process_id => process.id,
        :expression_id => presented.expression.expid,
        :error_class_name => "NaughtyParticipant::StupidError",
        :message => "Oh crumb.",
        :backtrace => presented.backtrace
      })
    end
  end
end