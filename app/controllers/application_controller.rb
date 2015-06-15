class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin?
    current_user && current_user.admin?
  end

  def authenticate
    redirect_to(root_path) if current_user.nil?
  end

  def require_admin
    render file: "/public/404.html" unless current_admin?       
  end
end
