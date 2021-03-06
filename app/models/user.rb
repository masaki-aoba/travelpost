class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :country, presence: true, length: {maximum: 50}
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :posts, dependent: :destroy
  # Favoriteクラスのインスタンスを返す
  has_many :favorites, dependent: :destroy
  # Postクラスのインスタンスを返す
  has_many :favorite_posts, through: :favorites, source: :post, dependent: :destroy
  
  #お気に入り登録
  def favorite(post)
      self.favorites.find_or_create_by(post_id: post.id)
  end
  #お気に入り削除
  def unfavorite(post)
    favorite = self.favorites.find_by(post_id: post.id)
    favorite.destroy if favorite
  end
  #お気に入り判断
  def favorite?(post)
    self.favorite_posts.include? post
  end
  
end
