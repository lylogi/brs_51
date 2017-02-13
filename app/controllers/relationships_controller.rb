class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def index
    @user  = User.find_by id: params[:id]
    if @user
      @title = params[:relationship]
      @users = @user.send(@title).paginate page: params[:page]
      render "users/show_follow"
    else
      flash[:warning] = t "users.error_find_user"
      redirect_to root_url
    end
  end

  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow @user
      @relationship = current_user.active_relationships
        .find_by followed_id: @user.id
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    else
      flash[:warning] = t "users.error_find_user"
      redirect_to root_url
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    if @user
      current_user.unfollow @user
      @relationship = current_user.active_relationships.build
      respond_to do |format|
        format.html {redirect_to @user}
        format.js
      end
    else
      flash[:warning] = t "users.error_find_user"
      redirect_to root_url
    end
  end
end
