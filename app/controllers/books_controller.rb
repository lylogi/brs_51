class BooksController < ApplicationController
  before_action :logged_in_user

  def index
    @books = Book.order_by_time.paginate page: params[:page], per_page: Settings.per_page
    @categories = Category.all
    @books_search = Book.search(params[:search], params[:category_id])
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:warning] = t "admin.book.not_find"
      redirect_to root_url
    end
    @support = Supports::BookSupport.new @book
  end
end
