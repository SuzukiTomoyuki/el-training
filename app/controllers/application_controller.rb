class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def user_logged_in?
    if session[:user_id]
      begin
        @current_user = User.find_by(id: session[:user_id])
      rescue ActiveRecord::RecordNotFound
        reset_user_session
      end
    end
    return if @current_user
    flash[:warning] = "ログインしてください"
    redirect_to login_path
  end

  def admin_user?
    if User.find(session[:user_id]).admin?
    else
      render partial: 'errors/forbidden'
    end
  end

  def reset_user_session
    session[:user_id] = nil
    @current_user = nil
  end
end
