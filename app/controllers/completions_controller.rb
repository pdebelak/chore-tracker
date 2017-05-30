class CompletionsController < ApplicationController
  require_user

  def create
    task.complete! current_user
    flash[:success] = "Task completed!"
    respond_to do |format|
      format.html { redirect_to list_path task.list }
      format.js do
        @list = task.list
        @grouped_tasks = @list.task_with_completions.grouped_by_completion
        render "tasks/refresh_tasks"
      end
    end
  end

  def destroy
    task.completions.find(params[:id]).destroy!
    respond_to do |format|
      format.html { redirect_to list_path task.list }
      format.js do
        @list = task.list
        @grouped_tasks = @list.task_with_completions.grouped_by_completion
        render "tasks/refresh_tasks"
      end
    end
  end

  private

  def task
    @_task ||= current_user
      .lists.find(params[:list_id])
      .tasks.find(params[:task_id])
  end
end
