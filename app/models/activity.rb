class Activity < ApplicationRecord
  enum action_type: [:followed, :reading, :favorite, :reviewed, :commented]
  enum target_type: [:user_target, :book_target, :review_target]
  belongs_to :user
  has_many :likes, dependent: :destroy
end
