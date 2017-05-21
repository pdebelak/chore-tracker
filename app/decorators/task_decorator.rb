class TaskDecorator
  def self.schedule_options
    Task.schedules.map { |schedule| [schedule.capitalize, schedule] }
  end

  delegate :weekly?, :monthly?, :description, to: :task

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

  private

  attr_reader :task
end
