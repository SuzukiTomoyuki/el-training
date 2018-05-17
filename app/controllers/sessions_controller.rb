class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_name(params[:name])
    if user and user.authenticate(params[:pass])
      session[:user_id] = user.id
    else
      render "new"
    end
  end

  def destroy
  end
end
