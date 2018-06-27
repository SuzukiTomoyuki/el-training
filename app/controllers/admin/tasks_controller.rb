class Admin::TasksController < ApplicationController
  layout 'admin_tasks'

  before_action :user_logged_in?, :admin_user?

  helper_method :sort_column, :sort_direction

  def index
    @task = Task.new
    @user = current_user
    @group = Group.new

    tasks = Task.all.where(user_id: session[:user_id]).where.not(status: 0)
    @task_status_done_count = Task.all.where(user_id: session[:user_id]).where(status: 0).size
    time_now = Time.now - (Time.now.hour * 60 * 60 + Time.now.min * 60 + Time.now.sec)
    @task_blue_count = tasks.where("deadline > '#{time_now + 3.day}'").size
    @task_yellow_count = tasks.where(deadline: (time_now)..(3.days.since)).size
    @task_red_count = tasks.where("deadline < '#{time_now}'").size

    tasks = Task.all.where(charge_user_id: session[:user_id])
    @tasks_to_do = tasks.get_by_status 2
    @tasks_doing = tasks.get_by_status 1
    @tasks_done = tasks.get_by_status 0
  end

  def index_group
    check_join_group
    @task = Task.new
    @user = current_user
    @group = Group.new

    @group_tasks = Group.find(params[:group_id])

    tasks = Task.all.where(id: @group_tasks.tasks.ids).where.not(status: 0)
    @task_status_done_count = Task.all.where(id: @group_tasks.tasks.ids).where(status: 0).size
    time_now = Time.now - (Time.now.hour * 60 * 60 + Time.now.min * 60 + Time.now.sec)
    @task_blue_count = tasks.where("deadline > '#{time_now + 3.day}'").size
    @task_yellow_count = tasks.where(deadline: (time_now)..(3.days.since)).size
    @task_red_count = tasks.where("deadline < '#{time_now}'").size

    tasks = Task.all.where(id: @group_tasks.tasks.ids).order(sort_column + ' ' + sort_direction)
    @tasks_to_do = tasks.get_by_status 2
    @tasks_doing = tasks.get_by_status 1
    @tasks_done = tasks.get_by_status 0
    # pp Date.new(tasks.first.deadline.year, tasks.first.deadline.month, tasks.first.deadline.day) - Date.today
  end


  def new
    @task = Task.new
  end

  def create
    @task = Task.new(create_params)
    @user = current_user
    group = Group.find(params[:group_id])
    @task.user_id = current_user.id
    if @task.save
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
      flash[:notice] = "タスクが編集されました"
    else
      render json: { messages: @task.errors.full_messages }, status: :bad_request
    end
  end

  def show
    @task = find_task_by_id
  end

  def destroy
    @task = find_task_by_id
    @task.destroy
    flash[:notice] = "タスクが削除されました"
    redirect_back(fallback_location: root_path)
  end

  private
  def create_params
    params.require(:task).permit(:id, :caption, :priority, :deadline, :status, :label, :created_at, :user_id, :charge_user_id, :group_ids)
  end

  def find_task_by_id
    Task.find(params[:id])
  end

  def check_join_group
    user = current_user
    if (user.groups.where(id: params[:group_id]).empty? or !current_user.admin)
      redirect_to admin_root_path
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
