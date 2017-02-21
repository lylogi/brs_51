 class Supports::BookSupport
  attr_reader :book

  def initialize book
    @book = book
  end

  def comment
    Comment.new
  end

  def reviews
    @book.reviews.order_by_time
  end

  def favorites
    @book.favorites
  end

  def check_favorite current_user
    @book.favorites.find_by book_id: current_user
  end
end
