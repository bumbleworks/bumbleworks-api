describe Bumbleworks::Api::TasksController do
  let(:process) { Bumbleworks.launch!('task_process') }
  before(:each) do
    wait_until do
      process.tasks.count == 2
    end
  end

  describe "#index" do
    it "returns all tasks" do
      tasks = process.tasks.all
      get "/tasks"
      expect(last_response.body).to eq(
        json_presentation_of(tasks)
      )
    end
  end

  describe "#show" do
    it "returns requested task" do
      task = process.tasks.first
      get "/tasks/#{task.id}"
      expect(last_response.body).to eq(
        json_presentation_of(task)
      )
    end
  end

  describe "#claim" do
    it "claims and returns task" do
      task = process.tasks.first
      put "/tasks/#{task.id}/claim", :claimant => "horatio"
      expect(task.reload.claimant).to eq("horatio")
      expect(last_response.body).to eq(
        json_presentation_of(task)
      )
    end
  end

  describe "#release" do
    it "releases and returns task" do
      task = process.tasks.first
      task.claim("whiskey")
      put "/tasks/#{task.id}/release"
      expect(task.reload.claimant).to be_nil
      expect(last_response.body).to eq(
        json_presentation_of(task)
      )
    end
  end

  describe "#complete" do
    let(:task) { process.tasks.first }
    before(:each) do
      allow(Bumbleworks::Task).to receive(:find_by_id).
        with(task.id).
        and_return(task)
    end

    it "completes task and returns success" do
      expect(task).to receive(:complete).with(:foo => "bar", "foo" => "bar")
      put "/tasks/#{task.id}/complete", :foo => :bar
      expect(last_response.body).to eq(
        { :status => 'completed' }.to_json
      )
    end

    it "returns 422 with error message if task not completable" do
      allow(task).to receive(:complete).and_raise(
        Bumbleworks::Task::NotCompletable, "uh oh you can't do that"
      )
      put "/tasks/#{task.id}/complete", :foo => :bar
      expect(last_response.body).to eq(
        {
          :status => "not_completable",
          :message => "uh oh you can't do that"
        }.to_json
      )
      expect(last_response.status).to eq(422)
    end
  end
end