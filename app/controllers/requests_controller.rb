class RequestsController < ApplicationController
  before_action :logged_in_user
  before_action :find_request, only: :destroy
  
  def index
    @requests = current_user.requests.order_by_id
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @request = current_user.requests.build
  end

  def create
    @request = current_user.requests.build request_params
    if @request.save
      flash[:success] = t "flash.create_success"
      redirect_to requests_url
    else
      render :new
    end
  end
  
  def destroy
    if @request && @request.destroy
      flash[:success] = t "flash.request_destroy"
    else
      flash[:danger] = t "flash.request_destroy_error"
    end
    redirect_to requests_url
  end
  private
  def request_params
    params.require(:request).permit :title, :author_name, :publish_date, :content
  end

  def find_request
    @request = Request.find_by id: params[:id]
    unless @request
      flash[:warning] = t "requests.error_find_request"
      redirect_to requests_url
    end
  end
end
