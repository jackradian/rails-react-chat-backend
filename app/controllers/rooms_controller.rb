# frozen_string_literal: true
class RoomsController < ApplicationController
  def my_direct_rooms
    @rooms = Room.includes({ participants: :user }, :users, messages: :sender).where(
      room_type: "direct_room",
      participants: { user: current_user }
    ).order("messages.sent_at")
  end
end
