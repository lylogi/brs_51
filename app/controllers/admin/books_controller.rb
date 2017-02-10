class Admin::BooksController < ApplicationController
  before_action :verify_admin, except: :show
  before_action :find_book, only: :show

  def index
    @books = Book.all
  end

  def new
    @book = Book.new
    @categories = Category.all
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "admin.book.success"
      redirect_to admin_books_path
    else
      @categories = Category.all	
      render :new
    end
  end

  def show
  end

  private
  def book_params
    params.require(:book).permit :category_id, :title, :author_name,
      :pages, :publish_date, :cover, :description
  end

  def find_book
    @book = Book.find_by id: params[:id]
    unless @book
      flash[:warning] = t "admin.book.not_find"
      redirect_to root_url
    end
  end
end
