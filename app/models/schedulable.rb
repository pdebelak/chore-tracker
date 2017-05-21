module Schedulable
  def weekly?
    schedule == Task::WEEKLY
  end

  def monthly?
    schedule == Task::MONTHLY
  end
end
