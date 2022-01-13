# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :notification do
    user? { true }
    association :to, factory: :user
    association :from, factory: :user
    from_message

    trait :from_message do
      association :notificator, factory: :message
    end

    trait :from_order do
      association :notificator, factory: :order
    end

    trait :from_review do
      association :notificator, factory: :review
    end

    trait :from_com do
      association :notificator, factory: :comment
    end

    trait :from_rep do
      association :notificator, factory: :reply
    end

    trait :from_else do
      association :notificator, factory: :post
    end
  end
end
