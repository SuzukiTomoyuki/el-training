class Admin::UsersController < ApplicationController
  layout 'admin_users'
  before_action :admin_user?

  def index
    @users = User.all
    @user = current_user
    @group = Group.new
  end


  def destroy
    @user = find_user_by_id
    # pp @user
    if !@user.admin?
      pp @user
      destroy_task
      @user.destroy
      flash[:notice] = "ユーザとタスク削除完了"
      redirect_to admin_users_path
    elsif User.admin.group(:admin).size.values[0] == 1
      flash[:error] = "管理者が０人になるためユーザを削除できません"
      redirect_to admin_users_path
    end
  end

  def edit
    @user = find_user_by_id
  end

  def show
    @user = find_user_by_id
    @group = Group.new
  end


  def update
    @user = find_user_by_id
    if @user.update(create_params)
      flash[:notice] = "ユーザ情報を更新"
    else
      render json: { messages: @user.error.full_messages }, status: :bad_request
    end
  end

  private
  def create_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :admin, :image_name)
  end

  def find_user_by_id
    User.find(params[:id])
  end

  def destroy_task
    task = Task.find_by_user_id(find_user_by_id)
    if task.present?
      task.destroy
    end
  end
end
