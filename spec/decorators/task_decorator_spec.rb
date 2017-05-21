require "rails_helper"

describe TaskDecorator do
  let(:task) { build :task }
  let(:decorator) { described_class.new task }

  describe "#schedule_explanation" do
    subject { decorator.schedule_explanation }

    context "when the task is weekly" do
      let(:task) { build :task, schedule: Task::WEEKLY }

      it { is_expected.to eq "Once a week" }
    end

    context "when the task is monthly" do
      let(:task) { build :task, schedule: Task::MONTHLY }

      it { is_expected.to eq "Every month" }
    end
  end
end
