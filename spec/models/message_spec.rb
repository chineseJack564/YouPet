# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let(:message) { create(:message, sender_id: sender.id, recipient_id: recipient.id) }

  it 'is not valid without sender' do
    message.sender_id = nil
    expect(message).not_to be_valid
  end

  it 'is not valid without recipient' do
    message.recipient_id = nil
    expect(message).not_to be_valid
  end
end
