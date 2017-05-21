require "rails_helper"

describe TaskWithCompletion do
  describe "#complete?" do
    let(:task_with_completion) { described_class.find task.id }
    subject { task_with_completion.complete? }

    context "when task is not completed" do
      let(:task) { create :task }

      it { is_expected.to be false }
    end

    context "when task is completed" do
      let(:completion) { create :completion }
      let(:task) { create :task, schedule: Task::WEEKLY, completions: [completion] }

      it { is_expected.to be true }

      context "before the beginning of the week" do
        context "and the task is weekly" do
          let(:completion) { create :completion, created_at: Time.now.beginning_of_week - 1 }
          let(:task) { create :task, schedule: Task::WEEKLY, completions: [completion] }

          it { is_expected.to be false }
        end

        context "and the task is monthly" do
          let(:completion) { create :completion, created_at: Time.now.beginning_of_week - 1 }
          let(:task) { create :task, schedule: Task::MONTHLY, completions: [completion] }

          it { is_expected.to be true }
        end
      end

      context "before the beginning of the month" do
        let(:completion) { create :completion, created_at: Time.now.beginning_of_month - 1 }
        let(:task) { create :task, schedule: Task::MONTHLY, completions: [completion] }

        it { is_expected.to be false }
      end
    end
  end

  describe "#grouped_by_completion" do
    let(:completion1) { build :completion, task: nil, created_at: 2.weeks.ago }
    let!(:task1) { create :task, schedule: Task::WEEKLY, completions: [completion1] }
    let(:completion2) { build :completion, task: nil }
    let!(:task2) { create :task, schedule: Task::WEEKLY, completions: [completion2] }

    it "groups completed and not completed together" do
      grouped = described_class.grouped_by_completion
      expect(grouped.completed.map(&:id)).to eq [task2.id]
      expect(grouped.not_completed.map(&:id)).to eq [task1.id]
    end
  end
end
