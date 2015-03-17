describe Bumbleworks::Api::ProcessesController do
  describe "#index" do
    before(:each) do
      allow(Bumbleworks::Api::ProcessPresenter).to receive(:present).
        with(:processes).
        and_return(:presented_processes)
    end

    it "returns requested page with requested number of processes" do
      allow(Bumbleworks::Process).to receive(:all).
        with(:limit => 12, :offset => 24).
        and_return(:processes)
      get "/processes?page=3&limit=12"
      expect(last_response.body).to eq(
        json_presentation_of(:processes, :as => 'Process')
      )
    end

    it "defaults to limit 10" do
      allow(Bumbleworks::Process).to receive(:all).
        with(:limit => 10, :offset => 10).
        and_return(:processes)
      get "/processes?page=2"
      expect(last_response.body).to eq(
        json_presentation_of(:processes, :as => 'Process')
      )
    end

    it "defaults to page 1" do
      allow(Bumbleworks::Process).to receive(:all).
        with(:limit => 3, :offset => 0).
        and_return(:processes)
      get "/processes?limit=3"
      expect(last_response.body).to eq(
        json_presentation_of(:processes, :as => 'Process')
      )
    end
  end

  describe "#show" do
    it "returns requested instance" do
      process = Bumbleworks.launch!('task_process', :entity => Widget.new(41))
      wait_until { process.tasks.count == 2 }
      get "/processes/#{process.id}"
      expect(last_response.body).to eq(
        json_presentation_of(process)
      )
    end
  end
end