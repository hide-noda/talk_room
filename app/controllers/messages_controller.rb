class MessagesController < ApplicationController
  def index
    @message = Message.new
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user).order(id: "DESC")
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  def destroy
    @room = Room.find(params[:room_id])
    message = @room.messages.find(params[:id])
    if message.destroy
      redirect_to room_messages_path(@room)
    end
  end

  def checked
    message = Message.find(params[:id])
    if message.user_id != current_user.id
      if message.checked
        message.update(checked: false)
      else
        message.update(checked: true)
      end
    end
    item = Message.find(params[:id])
    render json: { message: item }
  end

  private

  def message_params
    params.require(:message).permit(:content,:image).merge(user_id: current_user.id)
  end
end
