FactoryBot.define do
  factory :room do
    room_type { Room.room_types[:direct_room] }
  end
end