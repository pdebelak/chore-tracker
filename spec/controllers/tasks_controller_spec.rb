require "rails_helper"

describe TasksController do
  let(:user) { create :user }

  before { session[:user_id] = user.id }

  describe "#create" do
    def do_create
      post :create, params: { list_id: list.id, task: { description: "A task", schedule: Task::WEEKLY } }
    end

    context "list does not belong to user" do
      let(:list) { create :list }

      it "404s" do
        expect { do_create }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "list belongs to user" do
      let(:list) { create :list, users: [user] }

      it "creates a task" do
        do_create
        expect(response).to redirect_to list_path(list)
        task = Task.first
        expect(task.description).to eq "A task"
        expect(task).to be_weekly
        expect(task.list).to eq list
        expect(flash[:success]).to be_present
      end

      context "and task is invalid" do
        it "renders the new page" do
          post :create, params: { list_id: list.id, task: { description: "A task", schedule: "yearly" } }
          expect(response).to be_ok
          expect(Task.all).to be_empty
        end
      end
    end
  end

  describe "#update" do
    let(:list) { create :list, users: [user] }
    let(:task) { create :task, list: list }

    it "updates the task" do
      put :update, params: { list_id: list.id, id: task.id, task: { description: "New description", schedule: Task::MONTHLY } }
      expect(response).to redirect_to list_path(list)
      task.reload
      expect(task.description).to eq "New description"
      expect(task).to be_monthly
      expect(flash[:success]).to be_present
    end

    context "with invalid params" do
      it "does not update the task" do
        expect { put :update, params: { list_id: list.id, id: task.id, task: { description: "", schedule: Task::MONTHLY } } }.not_to change { task.reload.description }
        expect(response).to be_ok
      end
    end
  end

  describe "#destroy" do
    let(:list) { create :list, users: [user] }
    let(:task) { create :task, list: list }

    it "destroys the task" do
      delete :destroy, params: { list_id: list.id, id: task.id }
      expect(response).to redirect_to list_path(list)
      expect { Task.find task.id }.to raise_error ActiveRecord::RecordNotFound
      expect(flash[:success]).to be_present
    end
  end
end
