require "rails_helper"

describe Task do
  describe "#complete!" do
    let(:task) { create :task }
    let(:user) { task.list.users.first }

    it "creates a completion" do
      expect { task.complete! user }.to change { Completion.count }.by 1
      completion = Completion.last
      expect(completion.user).to eq user
      expect(completion.task).to eq task
    end
  end
end
