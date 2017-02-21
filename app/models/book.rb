class Book < ApplicationRecord
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :reading_statuses, dependent: :destroy
  has_many :favorites, dependent: :destroy

  mount_uploader :cover, CoverUploader

  validates :title, presence: true, length: {maximum: 50}
  validates :author_name, presence: true, length: {maximum: 50}
  validates :pages, presence: true
  validates :publish_date, presence: true

  scope :order_by_time, -> {order created_at: :desc}
  scope :order_by_id, -> {order id: :desc}
  scope :search_book_by_search_params, -> search do
    where "title LIKE ? OR author_name LIKE ?",
      "%#{search}%", "%#{search}%" if search.present?
  end
  
  class << self	
    def search search, category_id
      if category_id.present?
        Category.find_by(id: category_id).books
      else
        all
      end.search_book_by_search_params(search)
    end
  end
end
