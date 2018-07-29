class UsersController < ApplicationController
  before_action :require_user_logged_in, except: [:new, :create]
  before_action :profile_check, only: [:profile_new]
  before_action :user_check, only: [:profile_new]
  
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @users = @user.matches
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録に失敗しました。'
      render :new
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.followings
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.followers
  end
  
  def profile_new
    @profile = current_user.build_profile
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def profile_check
    @profile = Profile.find_by(user_id: current_user.id)
    if @profile
      redirect_to user_path(current_user)
    end
    
    def user_check
      @user = User.find(params[:id])
      unless @user = current_user
        redirect_to user_path(current_user)
      end
    end
  end
end