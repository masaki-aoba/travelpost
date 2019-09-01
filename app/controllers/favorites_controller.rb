class FavoritesController < ApplicationController
  before_action :require_user_logged_in

  def create
    # user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    current_user.favorite(post)
    flash[:success] = 'いいねしました。'
    redirect_back(fallback_location: root_url)
  end

  def destroy
    #user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    current_user.unfavorite(post)
    flash[:success] = 'いいねを取り消しました。'
    redirect_back(fallback_location: root_url)
  end
end
