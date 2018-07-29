class ProfilesController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @profile = current_user.build_profile(profile_params)
    if @profile.save
      flash[:success] = 'プロフィールが正常に作成されました。'
      redirect_to current_user
    else
      flash.now[:danger] = 'プロフィールの作成に失敗しました。'
    　render :new
    end
  end

  private
  
  def profile_params
    params.require(:profile).permit(:age, :job, :hobby, :comment, :sex)
  end
  
end
