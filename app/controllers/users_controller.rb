class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new  
  end
  
  def edit
    if current_user != User.find(params[:id])
      redirect_to root_path
    end
  end
  
  def update
    if  current_user != User.find(params[:id])
      redirect_to root_path
    elsif @user.update(user_params)
      redirect_to edit_user_path , notice: 'ユーザー情報を編集しました'
    else
      render 'edit'
    end  
  end  
  
  def create
    @user = User.new(user_params)
    if @user.save
       flash[:success] = "Welcome to the Sample App"
       redirect_to @user
    else
      render 'new'
    end
  end  
  
  def followings
    @user = User.find(params[:id])
    @follower = @user.following_users #ここを追加しました！
  end  
  
  def followers
    @user = User.find(params[:id])
    @followed = @user.follower_users
  end  
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :area, :profile)  
  end
  
  def set_user
    @user = User.find(params[:id])  
  end
end
