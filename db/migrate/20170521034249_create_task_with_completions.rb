class CreateTaskWithCompletions < ActiveRecord::Migration[5.0]
  def change
    create_view :task_with_completions
  end
end
