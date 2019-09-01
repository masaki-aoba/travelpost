class Post < ApplicationRecord
  belongs_to :user
  # Favoriteクラスのインスタンスを返す
  has_many :favorites, dependent: :destroy
  # Userクラスのインスタンスを返す
  has_many :favorite_users, through: :favorites, source: :user, dependent: :destroy
  
  validates :sightseeing, presence: true, length: { maximum: 50 }
  validates :country_spot, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :evaluation, presence: true
  
  mount_uploader :image_url, ImageUrlUploader
end
