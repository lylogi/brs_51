class BooksController < ApplicationController
  before_action :logged_in_user

  def index
    @books = Book.order_by_time.paginate page: params[:page], per_page: Settings.per_page
  end

  def show
    @book = Book.find_by id: params[:id]
    @reviews = @book.reviews.order_by_time
    unless @book
      flash[:warning] = t "admin.book.not_find"
      redirect_to root_url
    end
    @comment = Comment.new
  end
end
