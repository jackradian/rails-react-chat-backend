FactoryBot.define do
  factory :participant do
    association :room
    association :user
    status { Participant.statuses[:accepted] }
  end
end