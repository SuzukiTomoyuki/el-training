class Api::TasksController < ApplicationController
  def index
  end

  def calendar
    @user = current_user
    group_tasks = Group.find(@user.groups.ids)
    @tasks = []
    from = Time.local(params[:calendar][:year], params[:calendar][:month])
    to   = from + 1.month
    group_tasks.each do |group_task|
      tasks = group_task.tasks.where.not(status: "done")
      tasks.where(deadline: from...to).order(deadline: :desc).each do |task|
        # pp task.charge_user.image_name
        user_image = "/assets/images/users"
        if task.charge_user.image_name == "default_user.png"
          user_image = "#{user_image}/#{task.charge_user.image_name}"
        else
          user_image = "#{user_image}/#{task.charge_user.id}/#{task.charge_user.image_name}"
        end
        @tasks.push(group:group_task.name, caption: task.caption, charge_user: task.charge_user.name, deadline: task.deadline, user_image: user_image, charge_user_id: task.charge_user.id, task_id: task.id)
      end
    end
    render 'calendar', formats: 'json', handlers: 'jbuilder'
  end

  def mail
    user = current_user
    sender = User.find(params[:mail][:user_id])
    sender.oko = true
    sender.save
    task = Task.find(params[:mail][:task_id])
    RelationshipMailer.oko_notification(user, sender, task).deliver
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
