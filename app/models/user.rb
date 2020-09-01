class User < ApplicationRecord
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages
  has_many :relationships, dependent: :destroy
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id', dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  KANA_RAGEX = /\A[ァ-ヶー－]+\z/.freeze
  with_options presence: true do
    validates :family_name
    validates :last_name
    validates :family_name_kana, format: {with: KANA_RAGEX}
    validates :last_name_kana, format: {with: KANA_RAGEX}
  end

end
