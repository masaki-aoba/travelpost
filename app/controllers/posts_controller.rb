class PostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy]

  
  def index
    if logged_in?
      @post = current_user.posts.build  # form_with 用
      @posts = current_user.posts.order(id: :desc).page(params[:page])
    end
  end
  
  def show
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = 'postを投稿しました。'
      redirect_to root_url
    else
      flash.now[:danger] = 'postの投稿に失敗しました。'
      render :new
    end
  end

  
  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = 'post は正常に更新されました'
      redirect_to @post
    else
      flash.now[:danger] = 'post は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @post.destroy
    flash[:success] = 'post は正常に削除されました'
    redirect_back(fallback_location: root_url)
  end
  
  

  
  private
  # Strong Parameter
  def post_params
    params.require(:post).permit(:sightseeing, :country_spot, :content, :evaluation, :image_url, :image_url_cache)
  end
  
  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    unless @post
      redirect_to root_url
    end
  end
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    # 攻撃者に余計な情報は与えない
    if @post.nil? || @post.user != current_user
      flash[:notice] = "権限がありません。"
      redirect_to root_url
    end
    # if @post.nil?
    #   flash[:notice] = "権限がありません。"
    #   redirect_to root_url
    # elsif @post.user_id != @current_user.id
    #   flash[:notice] = "権限がありません"
    #   redirect_to root_url
    # end
  end
end
