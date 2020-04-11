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

  def send_message(msg)
    if msg["sent_at"] && msg["content"]
      sent_at = Time.at(msg["sent_at"] / 1000.0)
      SaveMessageWorker.perform_async({
        room_id: @room.id,
        sender_id: current_user.id,
        sent_at: sent_at,
        content: msg["content"]
      })
      RoomChannel.broadcast_to(
        @room,
        {
          sender_nickname: current_user.nickname,
          sent_at: sent_at.strftime("%Y/%m/%d %H:%M"),
          content: msg["content"]
        }
      )
    end
  end

  def set_active_room
    current_user.participants.each do |p|
      if p.room_id == @room.id
        p.update(is_current: true)
      else
        p.update(is_current: false)
      end
    end
  end

  def unsubscribed; end

  private

  def message_params
    params.permit(:sender_id, :sent_at, :content)
    params[:room_id] = @room.id
  end
end
