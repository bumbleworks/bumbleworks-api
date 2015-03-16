describe Bumbleworks::Api::ExpressionPresenter do
  let(:process) { Bumbleworks.launch!('task_process') }
  let(:presented) { process.expression_at_position('0_0_1') }

  subject { described_class.new(presented) }

  describe "#to_hash" do
    it "returns hash representation of expression" do
      wait_until { process.tasks.count == 2 }
      expect(subject.to_hash).to eq({
        :expression_id => presented.expid,
        :process_id => presented.process.id,
        :tree => presented.tree
      })
    end

    context "with error" do
      let(:process) { Bumbleworks.launch!('error_process') }
      let(:presented) { process.expression_at_position('0_0') }

      it "includes presented error" do
        wait_until { process.reload.errors.count == 1 }
        error = Bumbleworks.errors.first
        expect(subject.to_hash).to eq({
          :expression_id => presented.expid,
          :process_id => presented.process.id,
          :tree => presented.tree,
          :error => Bumbleworks::Api::ErrorPresenter.present(error).to_hash
        })
      end
    end
  end
end