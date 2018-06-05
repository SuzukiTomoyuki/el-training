class TasksController < ApplicationController
  layout "tasks"

  before_action :user_logged_in?

  helper_method :sort_column, :sort_direction

  def index
    # task_list -> tasks
    @task = Task.new
    @user = User.find(session[:user_id])
    # @groups = Group.find(params[:group_id])
    @tasks = Task.all.order(sort_column + ' ' + sort_direction)
    if params[:caption].present?
      @tasks = @tasks.get_by_caption params[:caption]
    end
    if params[:status].present?
      @tasks = @tasks.get_by_status params[:status]
    end

    @group = Group.find(params[:group_id])

    @tasks_to_do = Task.all.where(id: @group.tasks.ids).order(sort_column + ' ' + sort_direction).get_by_status 2
    @tasks_doing = Task.all.where(id: @group.tasks.ids).order(sort_column + ' ' + sort_direction).get_by_status 1
    @tasks_done = Task.all.where(id: @group.tasks.ids).order(sort_column + ' ' + sort_direction).get_by_status 0

  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(create_params)
    @user = User.find(session[:user_id])
    group = Group.find(params[:group_id])
    @task.user_id = User.find(session[:user_id]).id
    if @task.save!
      group.group_tasks.create(task: @task)
      flash[:notice] = "タスクが追加されました"
    else
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

  def show
    @task = find_task_by_id
    # @id =  123
  end

  def destroy
    @task = find_task_by_id
    @task.destroy
    flash[:notice] = "悲しみ"
    redirect_to tasks_path
  end

  private
  def create_params
    params.require(:task).permit(:id, :caption, :priority, :deadline, :status, :label, :created_at, :user_id, :group_id)
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
