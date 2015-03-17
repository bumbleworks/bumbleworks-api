describe Bumbleworks::Api::WorkersController do
  before(:each) do
    Bumbleworks.start_worker!
    allow(Time).to receive(:now).and_return(Time.now)
  end

  describe "#index" do
    it "returns all workers" do
      allow(Time).to receive(:now).and_return(Time.now)
      workers = Bumbleworks::Worker::Info.all
      expect(Bumbleworks::Worker).to receive(:refresh_worker_info)
      get "/workers"
      expect(last_response.body).to eq(
        json_presentation_of(workers, :as => 'Worker')
      )
    end
  end

  describe "#show" do
    it "returns requested worker" do
      worker = Bumbleworks::Worker::Info.first
      expect(Bumbleworks::Worker).to receive(:refresh_worker_info)
      get "/workers/#{worker.id}"
      expect(last_response.body).to eq(
        json_presentation_of(worker, :as => 'Worker')
      )
    end
  end

  describe "#change_state" do
    let(:worker) { Bumbleworks::Worker::Info.first }
    before(:each) do
      allow(Bumbleworks::Worker::Info).to receive(:[]).
        with(worker.id).and_return(worker)
    end

    it "sends shutdown to given worker" do
      expect(worker).to receive(:shutdown)
      put "/workers/#{worker.id}/command/shutdown"
      expect(last_response.body).to eq(
        { "status" => "shutdown sent" }.to_json
      )
    end

    it "sends pause to given worker" do
      expect(worker).to receive(:pause)
      put "/workers/#{worker.id}/command/pause"
      expect(last_response.body).to eq(
        { "status" => "pause sent" }.to_json
      )
    end

    it "sends unpause to given worker" do
      expect(worker).to receive(:unpause)
      put "/workers/#{worker.id}/command/unpause"
      expect(last_response.body).to eq(
        { "status" => "unpause sent" }.to_json
      )
    end

    it "returns 404 if unknown command is sent" do
      put "/workers/#{worker.id}/command/dance"
      expect(last_response.body).to eq(
        { :error => "not_found" }.to_json
      )
      expect(last_response.status).to eq(404)
    end
  end

  describe "#change_global_state" do
    it "sends shutdown to all workers" do
      expect(Bumbleworks::Worker).to receive(:shutdown_all)
      put "/workers/command/shutdown"
      expect(last_response.body).to eq(
        { "status" => "shutdown sent" }.to_json
      )
    end

    it "sends pause to all workers" do
      expect(Bumbleworks::Worker).to receive(:pause_all)
      put "/workers/command/pause"
      expect(last_response.body).to eq(
        { "status" => "pause sent" }.to_json
      )
    end

    it "sends unpause to all workers" do
      expect(Bumbleworks::Worker).to receive(:unpause_all)
      put "/workers/command/unpause"
      expect(last_response.body).to eq(
        { "status" => "unpause sent" }.to_json
      )
    end

    it "returns 404 if unknown command is sent" do
      put "/workers/command/dance"
      expect(last_response.body).to eq(
        { :error => "not_found" }.to_json
      )
      expect(last_response.status).to eq(404)
    end
  end

  describe "#prune_stopped_workers" do
    it "prunes stale worker info" do
      expect(Bumbleworks::Worker::Info).to receive(:purge_stale_worker_info)
      delete "/workers/prune"
      expect(last_response.body).to eq(
        { :status => "pruned_stale_worker_info" }.to_json
      )
    end
  end
end