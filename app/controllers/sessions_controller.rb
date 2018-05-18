class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    p user
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      p user.email
      redirect_to tasks_path
    else
      p "dfscfgsedvbgrfvsdbhgdgx"
      flash[:error] = "メールアドレスもしくはパスワードが違います"
      render "new"
    end
  end

  def destroy
  end
end
