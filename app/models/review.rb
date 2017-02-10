class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  has_many :comments, dependent: :destroy

  validates :rate, presence: true
  validates :content, presence: true

  scope :order_by_time, -> {order created_at: :desc}
end
