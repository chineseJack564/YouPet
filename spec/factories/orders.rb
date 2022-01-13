# frozen_string_literal: true

require 'faker'

FactoryBot.define do
  factory :order do
    body { Faker::Lorem.sentence }
    association :user
    association :post
  end
end
