describe Bumbleworks::Api::ExpressionsController do
  let(:process) { Bumbleworks.launch!('task_process') }
  let(:expression) { process.expression_at_position('0_0_1') }
  before(:each) do
    wait_until { process.reload.tasks.count == 2 }
  end

  describe "#show" do
    it "returns requested expression" do
      get "/processes/#{process.id}/expressions/#{expression.expid}"
      expect(last_response.body).to eq(
        json_presentation_of(expression)
      )
    end
  end

  describe "#cancel" do
    it "attempts to cancel expression and returns success" do
      allow_any_instance_of(described_class).to receive(:expression).
        and_return(expression)
      expect(expression).to receive(:cancel!)
      delete "/processes/#{process.id}/expressions/#{expression.expid}/cancel"
      expect(last_response.body).to eq(
        { :status => 'cancelled' }.to_json
      )
    end
  end

  describe "#kill" do
    it "attempts to kill expression and returns success" do
      allow_any_instance_of(described_class).to receive(:expression).
        and_return(expression)
      expect(expression).to receive(:kill!)
      delete "/processes/#{process.id}/expressions/#{expression.expid}/kill"
      expect(last_response.body).to eq(
        { :status => 'killed' }.to_json
      )
    end
  end
end