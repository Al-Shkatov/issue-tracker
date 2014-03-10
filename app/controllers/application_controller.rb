class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_is_logged
  
  
  def dbg(*params)
    @debug_params=params if Rails.env.development? || Rails.env.test?
  end
  
  protected
  def is_logged?
    !current_user.nil?
  end
  def current_user
    @current_user ||= session[:current_user_id] && User.find_by_id(session[:current_user_id])
  end
  private 
  def set_is_logged
    @is_logged=is_logged?
  end
end
