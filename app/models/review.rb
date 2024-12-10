class Review < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :body,   presence: true
  validates :rating, presence: true
end
