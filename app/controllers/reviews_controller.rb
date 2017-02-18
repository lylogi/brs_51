class ReviewsController < ApplicationController
  before_action :logged_in_user
  before_action :find_review, except: [:new, :create]
  before_action :find_book

  def new
    @review = @book.reviews.build
  end

  def create
    @review = @book.reviews.build review_params
    @review.user_id = current_user.id
    if @review.save
      flash[:success] = "review.success"
      redirect_to @book
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @review.update_attributes review_params
      flash[:success] = t "review.success_update"
      redirect_to @book
    else
      redirect_to :edit
    end
  end

  def destroy
    if @review && @review.destroy
      flash[:success] = t "review.success_delete"
    else
      flash[:danger] = t "review.danger_delete"
    end
    redirect_to @book
  end

  private
  def review_params
    params.require(:review).permit :user_id, :content, :rate
  end

  def find_review
    @review = Review.find_by id: params[:id]
    unless @review
      flash[:warning] = t "review.not_find"
      redirect_to root_url
    end
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:warning] = t "admin.book.not_find"
      redirect_to root_url
    end
  end
end
