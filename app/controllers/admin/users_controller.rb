class Admin::UsersController < ApplicationController
  def index
    @users = User.all
  end

  def update

  end

  def destroy

  end

  def edit
  end

  private
  def create_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation)
  end

  def find_user_by_id
    User.find(params[:id])
  end
end
