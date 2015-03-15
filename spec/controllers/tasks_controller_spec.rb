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
        json_presentation_of(tasks, :as => 'Task')
      )
    end
  end

  describe "#show" do
    it "returns requested task" do
      task = process.tasks.first
      get "/tasks/#{task.id}"
      expect(last_response.body).to eq(
        json_presentation_of(task, :as => 'Task')
      )
    end
  end
end