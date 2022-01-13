# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence }
    association :sender, factory: :user
    association :recipient, factory: :user
    association :chat, factory: :chat
  end
end
