class ReadingStatus < ApplicationRecord
  enum status: [:unread, :reading, :read]

  belongs_to :user
  belongs_to :book

  validates :user, presence: true
  validates :book, presence: true
end
