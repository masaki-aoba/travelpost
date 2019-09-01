class Post < ApplicationRecord
  belongs_to :user
  
  validates :sightseeing, presence: true, length: { maximum: 50 }
  validates :country, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :evaluation, presence: true
end
