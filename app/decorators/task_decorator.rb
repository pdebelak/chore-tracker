class TaskDecorator
  def self.schedule_options
    Task.schedules.map { |schedule| [schedule.capitalize, schedule] }
  end

  delegate :weekly?, :monthly?, :description, :last_completed_at, to: :task

  def initialize(task)
    @task = task
  end

  def schedule_explanation
    if weekly?
      "Once a week"
    elsif monthly?
      "Every month"
    end
  end

  def last_completed
    last_completed_at&.to_date
  end

  def task_class
    "task--completed" if task.complete?
  end

  private

  attr_reader :task
end
