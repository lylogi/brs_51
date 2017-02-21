class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :find_user, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @relationship = current_user.active_relationships.build
    @favorites = @user.favorites.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "users.welcome"
      log_in @user
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "controller.update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:warning] = t "users.error_find_user"
      redirect_to root_url
    end
  end

  def correct_user
    redirect_to root_url unless current_user.current_user? @user
  end
end
