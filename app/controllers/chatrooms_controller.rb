class ChatroomsController < ApplicationController

  def index
    @chatrooms = Chatroom.all

  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end

end
