class MessagesController < ApplicationController

  def new
    @messages = Message.all
    @message = Message.new
  end

  def create
    @message = Message.new(text: params[:message][:text])
  end
  
end
