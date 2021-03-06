class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :edit, :update, :show, :destroy, :likes ]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(25)
    @user =User.find(session[:user_id])
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.order(id: :desc).page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def edit
    @user =User.find(session[:user_id])
  end

  def update
    @user =User.find(session[:user_id])
    if @user.update(user_params)
      flash[:success] = 'User 情報は正常に更新されました'
      redirect_to @user
    else
      user.now[:danger] = 'User 情報は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @user =User.find(session[:user_id])
    @user.destroy
    flash[:success] = 'User は正常に削除されました'
    redirect_back(fallback_location: root_url)
  end
  
  #お気に入り投稿取得
  def likes
    @user = User.find(params[:id])
    @favorites = @user.favorite_posts.page(params[:page])
    counts(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :country, :email, :password, :password_confirmation)
  end
end