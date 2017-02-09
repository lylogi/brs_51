class Request < ApplicationRecord
  enum status: [:active, :cancelled]

  belongs_to :user
end
