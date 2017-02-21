class Admin::BooksController < ApplicationController
  before_action :verify_admin, except: :show
  before_action :find_book, except: [:index, :new, :create]
  before_action :load_categories, except: :index

  def index
    @categories = Category.all
    @books = Book.by_category(params[:category])
      .search_book_by_search_params(params[:search])
      .order_by_time
      .paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "admin.book.success"
      redirect_to admin_books_path
    else
      render :new
    end
  end

  def show
    @book = Book.find_by id: params[:id]
  end

  def edit
  end
  
  def update
    if @book.update_attributes book_params
      flash[:success] = t "admin.book.success_update"
      redirect_to admin_book_path
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "flash.destroy_success"
    else
      flash[:danger] = t "flash.destroy_error"
    end
    redirect_to admin_books_url
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

  def load_categories
    @categories = Category.all
  end
end
