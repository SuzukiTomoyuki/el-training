class TasksController < ApplicationController
  layout "tasks"

  before_action :user_logged_in?

  helper_method :sort_column, :sort_direction

  # method 化
  def index
    @task = Task.new
    @user = User.find(session[:user_id])
    @group = Group.new

    # current Userで　　無駄処理も消す statusをscope化
    tasks = Task.all.where(user_id: session[:user_id]).where.not(status: 0)
    @task_status_done_count = Task.all.where(user_id: session[:user_id]).where(status: 0).size
    # prace インジェクションのそうくつ
    time_now = Time.now - (Time.now.hour * 60 * 60 + Time.now.min * 60 + Time.now.sec)
    # 意味合いを持たせる変数名
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
    @user = User.find(session[:user_id])
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
    flash[:notice] = "タスクを削除しました"
    # redirect_to tasks_path
    redirect_back(fallback_location: root_path)
  end

  def calendar
    # @task = Task.new
    @user = User.find(session[:user_id])
    @group = Group.new
    group_tasks = Group.select("id").find(@user.groups.ids)
    @tasks = []
    @task_blue = []
    @task_red = []
    @task_green = []
    group_tasks.each{ |group_task|
      @tasks << (Task.all.where(id: group_task.tasks.ids).where.not(status: 0))
      # time_now = Time.now - (Time.now.hour * 60 * 60 + Time.now.min * 60 + Time.now.sec)
      # @task_blue.push([tasks.where("deadline > '#{time_now + 3.day}'")])
      # @task_yellow.push([tasks.where(deadline: (time_now)..(3.days.since))])
      # @task_red.push([tasks.where("deadline < '#{time_now}'")])
    }

  end

  private
  def create_params
    params.require(:task).permit(:id, :caption, :priority, :deadline, :status, :label, :created_at, :user_id, :group_id, :charge_user_id)
  end

  def find_task_by_id
    Task.find(params[:id])
  end

  def check_join_group
    user = User.find(session[:user_id])
    if (user.groups.where(id: params[:group_id]).empty?)
      redirect_to root_path
    end
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Task.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end
end
