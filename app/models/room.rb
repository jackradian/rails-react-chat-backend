class Room < ApplicationRecord
  has_many :participants, dependent: :destroy
  has_many :users, through: :participants
  has_many :messages, dependent: :destroy

  enum room_type: {
    direct_room: 0,
    public_room: 1,
    private_room: 2
  }
end
