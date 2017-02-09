class ReadingStatus < ApplicationRecord
  enum status: [:unread, :reading, :read]

  belongs_to :user
  belongs_to :book
end
