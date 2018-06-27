class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_filter :set_api_format

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

  private
  def set_api_format
    if request.subdomain == 'api' and request.format == :html
      request.format = :json
    end
  end

  def current_user
    @_current_user ||= User.find_by(id: session[:user_id])
  end


end
