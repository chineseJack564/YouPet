# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :comment do
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.sentence }
    association :sender, factory: :user
    association :post, factory: :post
  end

  factory :invalid_comment do
    title { Faker::Lorem.characters(number: 1) }
    content { Faker::Lorem.sentence }
    association :sender, factory: :user
    association :post, factory: :post
  end
end
