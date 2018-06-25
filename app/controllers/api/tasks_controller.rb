class Api::TasksController < ApplicationController
  def index
  end

  def calendar
    @user = User.find(session[:user_id])
    group_tasks = Group.find(@user.groups.ids)
    @tasks = []
    from = Time.local(params[:calendar][:year], params[:calendar][:month])
    to   = from + 1.month
    group_tasks.each do |group_task|
      group_task.tasks.where(deadline: from...to).order(deadline: :desc).each do |task|
        pp task.deadline
        @tasks.push(group:group_task.name, caption: task.caption, charge_user: task.charge_user.name, deadline: task.deadline)
      end
    end
    render 'calendar', formats: 'json', handlers: 'jbuilder'
  end

  def show

  end

  def update
    if params[:task][:id].present? or params[:task][:status].present?
      task = Task.find(params[:task][:id])
      if task.update(create_params)

      end
    end
  end

  private
  def create_params
    params.require(:task).permit(:id, :status)
  end
end
