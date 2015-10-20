class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
  helper_method :current_user

  def require_login
    if session[:user_id] == nil
      redirect_to "/sessions/new"
    end
  end

end
