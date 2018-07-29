class RoomsController < ApplicationController
  before_action :require_user_logged_in
  before_action :require_user_matches, only: [:show]
  
  def create
    user = User.find(params[:guest_id])
    @room = current_user.open_room(user)
    if @room.save
      flash[:success] = 'ルームを作成しました'
      redirect_to @room
    else
      flash.now[:danger] = 'ルームの作成に失敗しました。'
      redirect_to user_path(current_user)
    end
  end
  
  def show
    @comments = Comment.where(room_id: params[:id])
  end
  
  private
  def require_user_matches
    @room = Room.find(params[:id])
    unless @room.user_id == current_user.id || @room.guest_id == current_user.id
      redirect_to user_path(current_user)
    end
  end
    
end
