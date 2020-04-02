# frozen_string_literal: true
class Room < ApplicationRecord
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  has_many :messages, -> {order(:sent_at)}, dependent: :destroy

  enum room_type: {
    direct_room: 0,
    public_room: 1,
    private_room: 2
  }

  def self.direct_room_by_id(user_id, friend_id)
    Room.where(
      room_type: "direct_room"
    ).where(
      "id IN (
        SELECT DISTINCT p.room_id
        FROM participants AS p
          JOIN participants AS pp
          ON p.room_id = pp.room_id
          WHERE p.user_id = ? AND pp.user_id = ?
      )", user_id, friend_id
      )
  end
end
