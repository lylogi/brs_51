class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private
  def verify_admin
    unless logged_in? && current_user.is_admin
      flash[:danger] = t "admin.login.danger"
      redirect_to login_url
    end
  end
end
