describe Bumbleworks::Api::ProcessPresenter do
  let(:presented) { Bumbleworks.launch!('task_process', :entity => widget) }
  let(:widget) { Widget.new(41) }

  describe "#to_hash" do
    context "not in collection" do
      subject { described_class.new(presented) }

      it "returns full hash representation of process" do
        wait_until { presented.tasks.count == 2 }
        expect(subject.to_hash).to eq({
          :id => presented.id,
          :definition_name => "task_process",
          :subscribed_events => [],
          :entity => Bumbleworks::Api::EntityPresenter.present(widget).to_hash,
          :entity_name => widget.to_s,
          :original_tree => presented.original_tree
        })
      end

      it "doesn't include entity if process has none" do
        wait_until { presented.tasks.count == 2 }
        allow(presented).to receive(:entity).and_return(nil)
        expect(subject.to_hash.keys).not_to include(:entity)
      end
    end

    context "in collection" do
      subject { described_class.new(presented, :in_collection => true) }

      it "returns minimal hash representation of process" do
        wait_until { presented.tasks.count == 2 }
        expect(subject.to_hash).to eq({
          :id => presented.id,
          :definition_name => "task_process",
          :entity_name => widget.to_s,
          :subscribed_events => []
        })
      end
    end
  end
end