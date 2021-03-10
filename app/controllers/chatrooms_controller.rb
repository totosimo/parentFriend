class ChatroomsController < ApplicationController
  def index
    @chatrooms = policy_scope(Chatroom)
    my_chatrooms = current_user.chatrooms
    other_users = my_chatrooms.map { |chat| chat.users.reject { |user| user.eql?(current_user) } }
    @my_chat_users = []
    my_chatrooms.each_with_index do |chat, i|
      @my_chat_users << { chat: chat, other_u: other_users[i][0] }
    end
    @my_chat_users
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @message = Message.new
    authorize @chatroom
    chat_user_ids = @chatroom.user_chatrooms.map { |record| record.user_id }
    @user = User.find(chat_user_ids.reject { |id| id.eql?(current_user.id) })[0]
    # raise
  end

  def create
    cu = current_user
    u = User.find(params[:user_id])
    s_one = "#{u.id}-#{cu.id}"
    s_two = "#{cu.id}-#{u.id}"
    @chatroom = Chatroom.where("name like ? OR name like ?", s_one, s_two).first
    if @chatroom.present?
      #check for existing chatroom and redirect to it
      authorize @chatroom
      redirect_to chatroom_path(@chatroom)
    else
      #else create chatroom
      @chatroom = Chatroom.new(name: "#{cu.id}-#{u.id}")
      authorize @chatroom
      @user_chatroom = UserChatroom.new(user: cu, chatroom: @chatroom)
      @user_chatroom_two = UserChatroom.new(user: u, chatroom: @chatroom)
      if @chatroom.save && @user_chatroom.save && @user_chatroom_two.save
        redirect_to chatroom_path(@chatroom)
      else
        render 'users/show'
      end

    end

  end

end
