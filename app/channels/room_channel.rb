# frozen_string_literal: true
class RoomChannel < ApplicationCable::Channel
  def subscribed
    @room = Room.includes(:users, :messages).find_by(id: params[:room])
    stream_for(@room)
  end

  def receive(data)
    SaveMessageWorker.perform_async({
      room_id: @room.id,
      sender_id: current_user.id,
      sent_at: Time.current,
      content: data["message"]
    })
    RoomChannel.broadcast_to(@room,
      { room: @room, users: @room.users, messages: data["message"] })
  end

  def unsubscribed; end

  private

  def message_params
    params.permit(:sender_id, :sent_at, :content)
    params[:room_id] = @room.id
  end
end
