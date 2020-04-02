# frozen_string_literal: true
class RoomChannel < ApplicationCable::Channel
  def subscribed
    @room = Room.find_by_id(params[:room_id])
    stream_for(@room) if @room
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
