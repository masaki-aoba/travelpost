class Post < ApplicationRecord
  belongs_to :user
  # Favoriteクラスのインスタンスを返す
  has_many :favorites
  # Userクラスのインスタンスを返す
  has_many :favorite_users, through: :favorites, source: :user
  
  validates :sightseeing, presence: true, length: { maximum: 50 }
  validates :country, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :evaluation, presence: true
end
