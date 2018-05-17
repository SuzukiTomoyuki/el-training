class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
  end

  private
  def create_params
    params.require(:user).permit(:id, :name, :pass)
  end
end
