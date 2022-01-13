# frozen_string_literal: true

FactoryBot.define do
  factory :chat do
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
