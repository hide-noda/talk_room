class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many_attached :image

  validates :content, presence: true
end
