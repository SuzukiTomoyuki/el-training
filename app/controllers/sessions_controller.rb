class SessionsController < ApplicationController
  # skip_before_action :user_logged_in?

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user and user.authenticate(params[:password])
      session[:user_id] = user.id
      if user.oko
        redirect_to ayame_path
        return
      end
      flash[:success] = "ログインしました"
      redirect_to my_tasks_path
    else
      flash[:error] = "メールアドレスもしくはパスワードが違います"
      render "new"
    end
  end

  def destroy
    @_current_user = session[:user_id] = nil
    flash[:success] = "ログアウトしました"
    redirect_to login_path
  end
end
