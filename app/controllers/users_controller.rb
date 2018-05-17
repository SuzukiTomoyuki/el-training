class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    if @user.save
      flash[:notice] = "新しいユーザを登録しました"
    else
      render "new"
    end
  end

  private
  def create_params
    params.require(:user).permit(:id, :name, :email, :pass)
  end
end
