class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # before_action :user_logged_in?

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

  def reset_user_session
    session[:user_id] = nil
    @current_user = nil
  end
end
