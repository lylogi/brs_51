class FavoritesController < ApplicationController
  before_action :logged_in_user
  before_action :find_book

  def create
    @favorite = current_user.favorites.build favorite_params
    if @favorite.save
      respond_to do |format|
        format.html {redirect_to :back}
        format.js
      end
    end
  end

  def destroy
    @favorite = Favorite.find params[:id]
    @favorite.destroy if @favorite
    respond_to do |format|
      format.html {redirect_to @book}
      format.js
    end
  end

  private
  def favorite_params
    params.require(:favorite).permit :use_id, :book_id
  end

  def find_book
    @book = Book.find_by id: params[:favorite][:book_id]
    unless @book
      flash[:warning] = t "admin.book.not_find"
      redirect_to root_url
    end
  end
end
