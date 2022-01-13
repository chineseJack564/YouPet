# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    title { 'Any Title' }
    content { 'Anything' }
    anon { 1 }
    score { 1 }
    association :sender, factory: :user
    association :recipient, factory: :user
  end
end
