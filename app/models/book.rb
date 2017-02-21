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
  scope :search_book_by_search_params, -> search {
    where "title LIKE ? OR author_name LIKE ?",
      "%#{search}%", "%#{search}%" if search.present?}
  scope :by_category, -> category_id {
    where :category_id => category_id if category_id.present?}
end
