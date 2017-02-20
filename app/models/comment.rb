class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :content, presence: true
  
  scope :order_by_time, -> {order created_at: :desc}
end
