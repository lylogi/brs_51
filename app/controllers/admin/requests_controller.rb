class Admin::RequestsController < ApplicationController
  before_action :verify_admin
  before_action :find_request, only: :destroy

  def index
    @requests = Request.all
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def destroy
    if @request && @request.destroy
      flash[:success] = t "flash.request_destroy"
    else
      flash[:danger] = t "flash.request_destroy_error"
    end
    redirect_to admin_requests_url
  end

  private
  def find_request
    @request = Request.find_by id: params[:id]
    unless @request
      flash[:warning] = t "requests.error_find_request"
      redirect_to requests_url
    end
  end
end
