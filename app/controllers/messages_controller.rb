class MessagesController < ApplicationController
  def create
    @chatroom = Chatroom.find(params[:chatroom_id])
    @message = Message.new(message_params)
    @message.chatroom = @chatroom
    @message.user = current_user
    authorize @message
    if @message.save
      ChatroomChannel.broadcast_to(
        @chatroom,
        {
          html: render_to_string(partial: "message", locals: { message: @message }),
          message_user_id: @message.user.id,
          message_id: @message.id,
          message_user_name: @message.user.first_name
        }

      )
      redirect_to chatroom_path(@chatroom, anchor: "message-#{@message.id}")
    else
      render "chatrooms/show"
      # comment
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end


end
