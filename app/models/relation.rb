class Relation < ApplicationRecord
  has_many :follower, class_name: 'User'
  has_many :following, class_name: 'User'

  validates :follower_id, presence: true
  validates :following_id, presence: true
end
