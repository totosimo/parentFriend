class ChatroomsController < ApplicationController

  def index
    @chatrooms = policy_scope(Chatroom)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end

  def create
    @chatroom = Chatroom.create(name: 'Fantasy Chat Two')
    authorize @chatroom
    @user_chatroom = UserChatroom.create(user: current_user, chatroom: @chatroom)
    @user_chatroom_two = UserChatroom.create(user: User.find(params[:user_id]), chatroom: @chatroom)
    # @user_chatroom.chatroom = @chatroom
    # @user_chatroom.user = current_user
    # @user_chatroom.user = current_user
    raise
    # @user_chatroom = UserChatroom.new(user_id =current_user, chatroom_id = @chatroom)


  end

end
