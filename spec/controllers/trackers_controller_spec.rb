describe Bumbleworks::Api::TrackersController do
  before(:each) do
    Bumbleworks.launch!('waiting_process')
    wait_until { Bumbleworks::Tracker.count == 5 }
  end

  describe "#index" do
    it "returns all existing trackers" do
      get "/trackers"
      expect(last_response.body).to eq(
        json_presentation_of(Bumbleworks::Tracker.all, :as => 'Tracker')
      )
    end
  end

  describe "#show" do
    it "returns requested instance" do
      tracker = Bumbleworks::Tracker.all.first
      get "/trackers/#{tracker.id}"
      expect(last_response.body).to eq(
        json_presentation_of(tracker, :as => 'Tracker')
      )
    end
  end
end