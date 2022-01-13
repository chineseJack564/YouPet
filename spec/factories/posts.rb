# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { 'Any Title' }
    address { 'Anything' }
    description { 'Anything' }
    post_type { 1 }
    specie { 1 }
    association :user, factory: :user
    coord_x { 10.002 }
    coord_y { 201.333 }
  end
end
