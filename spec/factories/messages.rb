FactoryBot.define do
  factory :message do
    association :room
    association :sender, factory: :user
    sent_at { DateTime.now }
    content { "This is message content." }
  end
end