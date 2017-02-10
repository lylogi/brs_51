class BooksController < ApplicationController
  before_action :logged_in_user

  def index
    @books = Book.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:warning] = t "admin.book.not_find"
      redirect_to root_url
    end
  end
end
