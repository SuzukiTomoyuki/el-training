class Admin::UsersController < ApplicationController
  layout 'admin_users'

  def index
    @users = User.all
    @user = User.find(session[:user_id])
  end


  def destroy
    @user = find_user_by_id
    @user.destroy
    flash[:notice] = "ユーザとタスク削除完了"
    redirect_to admin_users_path
  end

  def edit
    @user = find_user_by_id
  end

  def show

  end


  def update
    @user = find_user_by_id
    p @user.name
    if @user.update(create_params)
      flash[:notice] = "ユーザ情報を更新"
    else
      render json: { messages: @user.error.full_messages }, status: :bad_request
    end
  end

  private
  def create_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :admin)
  end

  def find_user_by_id
    User.find(params[:id])
  end
end
