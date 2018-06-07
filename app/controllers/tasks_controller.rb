class TasksController < ApplicationController
  layout "tasks"

  before_action :user_logged_in?

  helper_method :sort_column, :sort_direction

  def index
    @task = Task.new
    @user = User.find(session[:user_id])
    @group = Group.new
    # @group_tasks = Group.find(params[:group_id])
    @tasks_to_do = Task.all.where(user_id: session[:user_id]).order(sort_column + ' ' + sort_direction).get_by_status 2
    @tasks_doing = Task.all.where(user_id: session[:user_id]).order(sort_column + ' ' + sort_direction).get_by_status 1
    @tasks_done = Task.all.where(user_id: session[:user_id]).order(sort_column + ' ' + sort_direction).get_by_status 0
  end

  def index_group
    @task = Task.new
    @user = User.find(session[:user_id])
    @group = Group.new

    @group_tasks = Group.find(params[:group_id])
    @tasks_to_do = Task.all.where(id: @group_tasks.tasks.ids).order(sort_column + ' ' + sort_direction).get_by_status 2
    @tasks_doing = Task.all.where(id: @group_tasks.tasks.ids).order(sort_column + ' ' + sort_direction).get_by_status 1
    @tasks_done = Task.all.where(id: @group_tasks.tasks.ids).order(sort_column + ' ' + sort_direction).get_by_status 0
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(create_params)
    @user = User.find(session[:user_id])
    group = Group.find(params[:group_id])
    pp group
    @task.user_id = User.find(session[:user_id]).id
    if @task.save!
      group.group_tasks.create(task: @task)
      flash[:notice] = "タスクが追加されました"
      # redirect_back(fallback_location: root_path)
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
      flash[:notice] = "タスクを更新"
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
    # redirect_to tasks_path
    redirect_back(fallback_location: root_path)
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
