class Admin::TasksController < ApplicationController
  layout 'admin_tasks'

  before_action :user_logged_in?, :admin_user?

  helper_method :sort_column, :sort_direction

  def index
    @task = Task.new
    @user = current_user
    @group = Group.new
    tasks_by_status(current_user.id, "my_tasks")
  end

  def index_group
    check_join_group
    @task = Task.new
    @user = current_user
    @group = Group.new
    @group_tasks = Group.find(params[:group_id])
    tasks_by_status(@group_tasks.tasks.ids, "group")
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

  def calendar
    @user = current_user
    @group = Group.new
    group_tasks = Group.select("id").find(@user.groups.ids)
    @tasks = []
    group_tasks.each{ |group_task|
      @tasks << (Task.all.where(id: group_task.tasks.ids).not_status_done)
    }
  end

  private
  # task_ids?, tasksを引数として渡す
  def tasks_by_status(task_ids, index_name)
    if index_name == "my_tasks"
      # tasks決定が重複しているのはNG
      tasks = Task.where(user_id: task_ids).not_status_done
      @task_status_done_count = Task.where(user_id: task_ids).status_done.size
    else
      tasks = Task.where(id: task_ids).not_status_done
      @task_status_done_count = Task.where(id: task_ids).status_done.size
    end
    time_now = Time.now - (Time.now.hour * 60 * 60 + Time.now.min * 60 + Time.now.sec)
    @task_blue_count = tasks.where("deadline > '#{time_now + 3.day}'").size
    @task_yellow_count = tasks.where(deadline: (time_now)..(3.days.since)).size
    @task_red_count = tasks.where("deadline < '#{time_now}'").size
    if index_name == "group"
      tasks = Task.where(id: task_ids).order(sort_column + ' ' + sort_direction)
    else
      tasks = Task.where(charge_user_id: task_ids)
    end
    @tasks_to_do = tasks.status_to_do
    @tasks_doing = tasks.status_doing
    @tasks_done = tasks.status_done
  end

  def create_params
    params.require(:task).permit(:id, :caption, :priority, :deadline, :status, :label, :created_at, :user_id, :charge_user_id, :group_ids)
  end

  def find_task_by_id
    Task.find(params[:id])
  end

  def check_join_group
    return if current_user.admin
    user = current_user
    if user.groups.where(id: params[:group_id]).empty?
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
