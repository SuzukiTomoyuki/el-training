class TasksListController < ApplicationController
  def index
    @task_list = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(create_params)
    if @task.save
      redirect_to tasks_list_index_path
    else
      render new_tasks_list_path
    end
  end

  def update
    @task = find_task_by_id
  end

  def destroy
    @task = find_task_by_id
    @task.destroy
    redirect_to tasks_list_index_path
  end

  private
  def create_params
    params.require(:task).permit(:id, :caption, :priority, :deadline, :state, :label)
  end

  def find_task_by_id
    Task.find(params[:id])
  end

end
