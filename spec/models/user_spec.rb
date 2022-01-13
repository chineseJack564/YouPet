# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { build(:user) }

  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a username' do
    user.username = nil
    expect(user).not_to be_valid
  end

  it 'is not valid without an email' do
    user.email = nil
    expect(user).not_to be_valid
  end

  it 'is not valid without a password' do
    user.password = nil
    expect(user).not_to be_valid
  end

  describe 'associations' do
    it 'has many comments' do
      c = described_class.reflect_on_association(:comments)
      expect(c.macro).to eq(:has_many)
    end

    it 'has many messages' do
      m = described_class.reflect_on_association(:messages)
      expect(m.macro).to eq(:has_many)
    end

    it 'has many posts' do
      p = described_class.reflect_on_association(:posts)
      expect(p.macro).to eq(:has_many)
    end

    it 'has many orders' do
      o = described_class.reflect_on_association(:orders)
      expect(o.macro).to eq(:has_many)
    end

    it 'has many notifications' do
      n = described_class.reflect_on_association(:notifications)
      expect(n.macro).to eq(:has_many)
    end

    it 'has many reviews' do
      r = described_class.reflect_on_association(:reviews)
      expect(r.macro).to eq(:has_many)
    end
  end
end
