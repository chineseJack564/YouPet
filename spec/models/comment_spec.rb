# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  let(:comment) { create(:comment, sender_id: user.id, post_id: post.id) }

  it 'is valid with valid attributes' do
    expect(comment).to be_valid
  end

  it 'is not valid without a title' do
    comment.title = nil
    expect(comment).not_to be_valid
  end

  it 'is not valid with a short title' do
    comment.title = 'nil'
    expect(comment).not_to be_valid
  end

  it 'is not valid without content' do
    comment.content = nil
    expect(comment).not_to be_valid
  end

  it 'is not valid without sender' do
    comment.sender_id = nil
    expect(comment).not_to be_valid
  end
end
