class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "layouts.please_login"
      redirect_to login_url
    end
  end

  def verify_admin
    unless logged_in? && current_user.is_admin
      flash[:danger] = t "admin.login.danger"
      redirect_to login_url
    end
  end
end
