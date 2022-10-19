# frozen_string_literal: true
FactoryBot.define do
  factory :room do
    transient do
      participant_1 { build(:user) }
      participant_2 { build(:user) }
    end

    room_type { Room.room_types[:direct_room] }

    trait :with_ten_direct_messages_of_two_users do
      after(:create) do |room, evaluator|
        create(:participant, room: room, user: evaluator.participant_1)
        create(:participant, room: room, user: evaluator.participant_2)
        sender_array = [evaluator.participant_1, evaluator.participant_2]
        10.times do
          create(:message, room: room, sender: sender_array.sample)
        end
      end
    end

    trait :with_two_participants do
      after(:create) do |room, evaluator|
        create(:participant, room: room, user: evaluator.participant_1)
        create(:participant, room: room, user: evaluator.participant_2)
      end
    end
  end
end
