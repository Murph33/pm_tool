class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def authenticate_user!
    redirect_to new_session_path, notice: "Please sign in" unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end

  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  helper_method :current_user

  def paginate projects
    pages = Array.new (((projects.length)/10) + projects.length % 10 == 0 ? 0 : 1) { Array.new(10) }
    i = 0
    projects.each_slice(10) { |page| pages[i] = page; i +=1 }
    pages
  end

  helper_method :paginate

end
