class ChatroomsController < ApplicationController
  def index
    @chatrooms = policy_scope(Chatroom)
    @my_chatrooms = current_user.chatrooms
    # raise
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
  end

  def create
    @chatroom = Chatroom.new(name: "Fantasy Chat #{Chatroom.count + 1}")
    authorize @chatroom
    @user_chatroom = UserChatroom.new(user: current_user, chatroom: @chatroom)
    @user_chatroom_two = UserChatroom.new(user: User.find(params[:user_id]), chatroom: @chatroom)
    if @chatroom.save && @user_chatroom.save && @user_chatroom_two.save
      redirect_to chatroom_path(@chatroom)
    else
      render 'users/show'
    end
  end

end
