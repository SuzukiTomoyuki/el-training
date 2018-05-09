class TasksListController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @task_list = Task.all.order(sort_column + ' ' + sort_direction)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(create_params)
    if @task.save
      flash[:notice] = "新しい喜びに感謝せよ。"
      redirect_to tasks_list_index_path
    else
      render 'new'
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
      render 'edit'
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
    params.require(:task).permit(:id, :caption, :priority_id, :deadline, :state, :label, :created_at)
  end

  def find_task_by_id
    Task.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "state"
  end

end
