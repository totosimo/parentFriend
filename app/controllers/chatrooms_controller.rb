class ChatroomsController < ApplicationController
  def index
    @chatrooms = policy_scope(Chatroom)
    @my_chatrooms = current_user.chatrooms
    @other_users = @my_chatrooms.map { |chat| chat.users.reject { |user| user.eql?(current_user) } }
    @my_chat_users = []
    @my_chatrooms.each_with_index do |chat, i|
      @my_chat_users << { chat: chat, other_u: @other_users[i][0] }
    end
    @my_chat_users
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
    chat_user_ids = @chatroom.user_chatrooms.map { |record| record.user_id }
    @name = User.find(chat_user_ids.reject { |id| id.eql?(current_user.id) })[0].first_name
    # raise
  end

  def create
    @chatroom = Chatroom.new(name: "#{current_user.first_name} - #{User.find(params[:user_id]).first_name}")
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
