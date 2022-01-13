# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post, user_id: user.id) }

  it 'is valid with valid attributes' do
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    post.title = nil
    expect(post).not_to be_valid
  end

  it 'is not valid with a short title' do
    post.title = 'nil'
    expect(post).not_to be_valid
  end

  it 'is not valid without address' do
    post.address = nil
    expect(post).not_to be_valid
  end

  it 'is not valid without description' do
    post.description = nil
    expect(post).not_to be_valid
  end

  it 'is not valid without post_type' do
    post.post_type = nil
    expect(post).not_to be_valid
  end

  it 'is not valid without specie' do
    post.specie = nil
    expect(post).not_to be_valid
  end

  it 'is not valid without owner' do
    post.user_id = nil
    expect(post).not_to be_valid
  end

  it { is_expected.to define_enum_for(:post_type).with(%i[Adoption Sale]) }

  it {
    expect(post).to define_enum_for(:specie).with(%i[Dog Cat Hamster
                                                     Bird Fish Rabbit Other])
  }
end
