# frozen_string_literal: true
FactoryBot.define do
  factory :message do
    association :room
    association :sender, factory: :user
    sent_at { Time.now }
    content { Faker::Quote.famous_last_words }
  end
end
