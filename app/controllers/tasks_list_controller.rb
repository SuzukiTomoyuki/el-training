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
      flash[:notice] = "新しい喜びに感謝せよ。"
      render new_tasks_list_path
    end
  end

  def edit
    @task = find_task_by_id
  end

  def update
    @task = find_task_by_id
    if @task.update(create_params)
      flash[:notice] = "より強い試練に励むことで主に信仰を示せ。"
      redirect_to tasks_list_index_path
    else
      render edit_tasks_list_path
    end
  end

  def destroy
    @task = find_task_by_id
    @task.destroy
    flash[:notice] = "一度約束したことを違えることは愚か者のすることだ。"
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
