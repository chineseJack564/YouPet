# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Review, type: :model do
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let(:review) { create(:review, sender_id: sender.id, recipient_id: recipient.id) }

  it 'is valid with valid attributes' do
    expect(review).to be_valid
  end

  it 'is not valid without a title' do
    review.title = nil
    expect(review).not_to be_valid
  end

  it 'is not valid with a short title' do
    review.title = 'nil'
    expect(review).not_to be_valid
  end

  it 'is not valid without content' do
    review.content = nil
    expect(review).not_to be_valid
  end

  it 'is not valid without sender' do
    review.sender_id = nil
    expect(review).not_to be_valid
  end

  it 'is not valid without recipient' do
    review.recipient_id = nil
    expect(review).not_to be_valid
  end

  it 'is not valid without anonymity selection' do
    review.anon = nil
    expect(review).not_to be_valid
  end

  it {
    expect(review).to define_enum_for(:score).with(%i[☆ ☆☆ ☆☆☆ ☆☆☆☆ ☆☆☆☆☆])
  }
end
