# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  let(:user) { create(:user) }
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let(:review) { create(:review, sender_id: sender.id, recipient_id: recipient.id) }
  let(:order) { create(:order, user_id: user.id) }
  let(:message) { create(:message, sender_id: sender.id, recipient_id: recipient.id) }

  describe 'all notifications' do
    before do
      @notification = create(:notification, to_id: recipient.id, from_id: sender.id)
    end

    it 'are not valid without a from' do
      @notification.from_id = nil
      expect(@notification).not_to be_valid
    end

    it 'are not valid without a to' do
      @notification.to_id = nil
      expect(@notification).not_to be_valid
    end
  end

  describe 'message notifications' do
    before do
      @notification = create(:notification, to_id: recipient.id, from_id: sender.id)
    end

    it 'is sent by a message' do
      expect(@notification.notificator).to be_instance_of Message
    end
  end

  describe 'review notifications' do
    before do
      @notification = create(:notification, :from_review, to_id: recipient.id, from_id: sender.id)
    end

    it 'is sent by a review' do
      expect(@notification.notificator).to be_instance_of Review
    end
  end

  describe 'order notifications' do
    before do
      @notification = create(:notification, :from_order, to_id: recipient.id, from_id: sender.id)
    end

    it 'is sent by an order' do
      expect(@notification.notificator).to be_instance_of Order
    end
  end
end
