class Request < ApplicationRecord
  enum status: [:active, :cancelled]

  belongs_to :user

  validates :title, presence: true, length: {maximum: 50}
  validates :author_name, presence: true, length: {maximum: 50}
  validates :publish_date, presence: true

  scope :order_by_id, -> {order id: :desc}
end
