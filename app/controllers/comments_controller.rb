class CommentsController < ApplicationController
  before_action :logged_in_user
  before_action :find_book, :find_review
  before_action :find_comment, except: [:new, :create]
  before_action :correct_user, except: [:new, :create]

  def create
    @comment = @review.comments.build comment_params
    if @comment
      @comment.user_id = current_user.id
      @comment.review_id = @review.id
      
      if @comment.save
        respond_to do |format|
          format.html {redirect_to @book}
          format.js
        end
      else
        flash[:warning] = t "comment.content"
        redirect_to @book
      end
    end
  end

  def update
    if @comment 
      @comment.update comment_params
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    end
  end

  def destroy
    if @comment 
      @comment.destroy
      respond_to do |format|
        format.html {redirect_to @book}
        format.js
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit :user_id, :review_id, :content
  end

  def find_book
    @book = Book.find_by id: params[:book_id]
    unless @book
      flash[:warning] = t "admin.book.not_find"
      redirect_to root_url
    end
  end

  def find_review
    @review = Review.find_by id: params[:review_id]
    unless @review
      flash[:warning] = t "review.not_find"
      redirect_to @book
    end
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash[:warning] = t "comment.not_find"
      redirect_to @book
    end
  end

  def correct_user
    redirect_to @book unless current_user.current_user? @comment.user
  end
end
