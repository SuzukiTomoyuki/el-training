class SessionsController < ApplicationController
  skip_before_action :user_logged_in?

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "ログインしました"
      redirect_to tasks_path
    else
      flash[:error] = "メールアドレスもしくはパスワードが違います"
      render "new"
    end
  end

  def destroy
    @_current_user = session[:user_id] = nil
    redirect_to login_path
  end
end
