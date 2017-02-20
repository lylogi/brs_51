class Book < ApplicationRecord
  belongs_to :category

  has_many :reviews, dependent: :destroy
  has_many :reading_statuses, dependent: :destroy

  mount_uploader :cover, CoverUploader

  validates :title, presence: true, length: {maximum: 50}
  validates :author_name, presence: true, length: {maximum: 50}
  validates :pages, presence: true
  validates :publish_date, presence: true

  scope :order_by_time, -> {order created_at: :desc}
end
