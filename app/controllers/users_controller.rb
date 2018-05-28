class UsersController < ApplicationController
  # skip_before_action :user_logged_in?, only: [new, create]

  def new
    @user = User.new
  end

  # def update
  #
  # end

  def create
    @user = User.new(create_params)
    if @user.save
      flash[:success] = "新しいユーザを登録しました"
      redirect_to login_path
    else
      render "new"
    end
  end

  private
  def create_params
    params.require(:user).permit(:id, :name, :email, :password, :password_confirmation)
  end
end
