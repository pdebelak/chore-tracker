require "rails_helper"

describe CompletionsController do
  let(:user) { create :user }

  before { session[:user_id] = user.id }

  describe "#create" do
    let(:list) { create :list, users: [user] }
    let(:task) { create :task, list: list }

    it "creates a completion for the task" do
      post :create, params: { list_id: list.id, task_id: task.id }
      completion = Completion.last
      expect(completion.user).to eq user
      expect(completion.task).to eq task
      expect(response).to redirect_to list_path(list)
    end

    context "js request" do
      it "refreshes tasks on the page" do
        post :create, format: :js, params: { list_id: list.id, task_id: task.id }
        completion = Completion.last
        expect(completion.user).to eq user
        expect(completion.task).to eq task
        expect(assigns :list).to eq list
        expect(assigns(:grouped_tasks).completed.map(&:id)).to eq [task.id]
      end
    end
  end

  describe "#destroy" do
    let(:list) { create :list, users: [user] }
    let(:task) { create :task, list: list }
    let!(:completion) { create :completion, task: task }

    it "destroys the most recent completion for the task" do
      delete :destroy, params: { list_id: list.id, task_id: task.id, id: completion.id }
      expect(response).to redirect_to list_path(list)
      expect { Completion.find completion.id }.to raise_error ActiveRecord::RecordNotFound
    end

    context "js request" do
      it "refreshes tasks on the page" do
        delete :destroy, format: :js, params: { list_id: list.id, task_id: task.id, id: completion.id }
        expect { Completion.find completion.id }.to raise_error ActiveRecord::RecordNotFound
        expect(assigns :list).to eq list
        expect(assigns(:grouped_tasks).not_completed.map(&:id)).to eq [task.id]
      end
    end
  end
end
