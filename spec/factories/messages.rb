FactoryBot.define do
  factory :message do
    association :room
    association :sender, factory: :user
    sent_at { DateTime.now }
    content { Faker::Quote.famous_last_words }
  end
end