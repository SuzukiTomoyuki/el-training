class TasksController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    # task_list -> tasks
    @task = Task.new
    @task_list = Task.all.order(sort_column + ' ' + sort_direction)
    if params[:caption].present?
      @task_list = @task_list.get_by_caption params[:caption]
    end
    if params[:status].present?
      @task_list = @task_list.get_by_status params[:status]
    end
    @task_list = @task_list.page(params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(create_params)
    if @task.save
      flash[:notice] = "新しい喜び"
      # redirect_to tasks_path
    else
      # render 'new'
      render json: { messages: @task.errors.full_messages }, status: :bad_request
    end
  end

  def edit
    @task = find_task_by_id
  end

  def update
    @task = find_task_by_id
    if @task.update(create_params)
      flash[:notice] = "より強い喜び"
      # redirect_to tasks_path
    else
      render json: { messages: @task.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @task = find_task_by_id
    @task.destroy
    flash[:notice] = "悲しみ"
    redirect_to tasks_path
  end

  private
  def create_params
    params.require(:task).permit(:id, :caption, :priority, :deadline, :status, :label, :created_at)
  end

  # before action で　セットタスク?
  def find_task_by_id
    Task.find(params[:id])
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end

end
