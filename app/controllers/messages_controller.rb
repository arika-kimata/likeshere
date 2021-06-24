class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @message = Message.new(message_params)
    @hobby = Hobby.find(params[:hobby_id])
    @messages = @hobby.messages.includes(:user).order('created_at DESC')
    if @message.valid?
      @message.save
      ActionCable.server.broadcast 'message_channel', message: @message, nickname: @message.user.nickname,
                                                      time: @message.created_at.strftime("%Y/%m/%d %H:%M:%S"), id: @hobby.id
      # redirect_to hobby_path(@hobby.id)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    respond_to do |format|
      format.json { render json: @message.id}
    end
  end

  private

  def message_params
    params.require(:message).permit(:text).merge(user_id: current_user.id, hobby_id: params[:hobby_id])
  end

end