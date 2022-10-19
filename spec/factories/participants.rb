# frozen_string_literal: true
FactoryBot.define do
  factory :participant do
    association :room
    association :user
    status { Participant.statuses[:accepted] }
  end
end
