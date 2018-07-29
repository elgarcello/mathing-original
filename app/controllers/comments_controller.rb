class CommentsController < ApplicationController
  def create
    @room = Room.find(params[:room_id])
    @comment = current_user.send_comment(@room, params[:comment][:content])
    
    if @comment.save
      flash[:success] = 'メッセージの送信に成功しました'
      redirect_to @room
    else
      flash[:danger] = 'メッセージの投稿に失敗しました'
      redirect_to @room
    end
  end
  
end
