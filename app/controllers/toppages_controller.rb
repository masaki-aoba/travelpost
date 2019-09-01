class ToppagesController < ApplicationController
  def index
    if logged_in?
      @posts = Post.all.order(id: :desc).page(params[:page])
      @user =User.find(session[:user_id])
    end
  end
end
