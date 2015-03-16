describe Bumbleworks::Api::ErrorsController do
  let(:process) { Bumbleworks.launch!('error_process') }
  let(:error) { Bumbleworks.errors.first }
  before(:each) do
    wait_until { process.reload.errors.count > 0 }
  end

  describe "#index" do
    it "returns all errors" do
      Bumbleworks.launch!('error_process')
      wait_until { Bumbleworks.errors.count == 2 }
      get "/errors"
      expect(last_response.body).to eq(
        json_presentation_of(Bumbleworks.errors, :as => 'Error')
      )
    end
  end

  describe "#show" do
    it "returns requested error" do
      get "/processes/#{process.id}/expressions/#{error.expression.expid}/error"
      expect(last_response.body).to eq(
        json_presentation_of(error, :as => 'Error')
      )
    end
  end

  describe "#replay" do
    after(:each) do
      NaughtyParticipant.naughty_is_ok = false
    end

    it "attempts to replay error and returns success" do
      NaughtyParticipant.naughty_is_ok = true
      put "/processes/#{process.id}/expressions/#{error.expression.expid}/error/replay"
      wait_until { !process.reload.running? }
      expect(last_response.body).to eq(
        { :status => 'replayed' }.to_json
      )
    end
  end
end