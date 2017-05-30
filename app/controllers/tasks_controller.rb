class TasksController < ApplicationController
  require_user

  def new
    @task = list.tasks.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @task = list.tasks.create task_params
    if @task.valid?
      flash[:success] = "Task created"
      respond_to do |format|
        format.html do
          redirect_to list_path list
        end
        format.js do
          @list = @task.list
          @grouped_tasks = @list.task_with_completions.grouped_by_completion
          render :refresh_tasks
        end
      end
    else
      render :new
    end
  end

  def edit
    @task = find_task
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    @task = find_task
    if @task.update task_params
      flash[:success] = "Task updated"
      respond_to do |format|
        format.html do
          redirect_to list_path(list)
        end
        format.js do
          @list = @task.list
          @grouped_tasks = @list.task_with_completions.grouped_by_completion
          render :refresh_tasks
        end
      end
    else
      render :edit
    end
  end

  def destroy
    task = find_task
    find_task.destroy!
    flash[:success] = "Task deleted"
    respond_to do |format|
      format.html do
        redirect_to list_path(list)
      end
      format.js do
        @list = task.list
        @grouped_tasks = @list.task_with_completions.grouped_by_completion
        render :refresh_tasks
      end
    end
  end

  private

  def task_params
    params.require(:task).permit :description, :schedule
  end

  def find_task
    list.tasks.find params[:id]
  end

  def list
    @_list ||= current_user.lists.find params[:list_id]
  end
end
