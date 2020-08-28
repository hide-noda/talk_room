class User < ApplicationRecord
  has_many :room_users
  has_many :rooms, through: :room_users
  has_many :messages
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
