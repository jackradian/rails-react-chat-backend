# frozen_string_literal: true
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@example.com" }
    password { "123456" }
    sequence(:nickname) { |n| "test#{n}" }
    sequence(:first_name) { |n| "John#{n}" }
    sequence(:last_name) { |n| "Lennon#{n}" }
  end
end
