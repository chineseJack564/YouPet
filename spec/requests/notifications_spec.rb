# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe 'Notifications', type: :request do
  let(:user) { create(:user) }
  let(:sender) { create(:user) }
  let(:recipient) { create(:user) }
  let(:review) { create(:review, sender_id: sender.id, recipient_id: recipient.id) }
  let(:order) { create(:order, user_id: user.id) }
  let(:message) { create(:message, sender_id: sender.id, recipient_id: recipient.id) }

  context 'when message notifications' do
    before do
      @notification = create(:notification, to_id: recipient.id, from_id: sender.id)
    end

    describe 'GET /show' do
      it 'redirects to message' do
        get notifications_show_path(@notification)
        expect(response).to redirect_to root_path
      end
    end
  end

  context 'when review notifications' do
    before do
      @notification = create(:notification, :from_review, to_id: recipient.id, from_id: sender.id)
    end

    describe 'GET /show' do
      it 'redirects to review' do
        get notifications_show_path(@notification)
        expect(response).to redirect_to reviews_show_path(@notification.notificator)
      end
    end
  end

  context 'when order notifications' do
    before do
      @notification = create(:notification, :from_order, to_id: recipient.id, from_id: sender.id)
    end

    describe 'GET /show' do
      it 'redirects to order' do
        get notifications_show_path(@notification)
        expect(response).to redirect_to @notification.notificator.post
      end
    end
  end

  context 'when comment notifications' do
    before do
      @notification = create(:notification, :from_com, to_id: recipient.id, from_id: sender.id)
    end

    describe 'GET /show' do
      it 'redirects to com' do
        get notifications_show_path(@notification)
        expect(response).to redirect_to @notification.notificator.post
      end
    end
  end

  # context 'when reply notifications' do
  #   before do
  #     @notification = create(:notification, :from_rep, to_id: recipient.id, from_id: sender.id)
  #   end

  #   describe 'GET /show' do
  #     it 'redirects to reply' do
  #       get notifications_show_path(@notification)
  #       expect(response).to redirect_to @notification.notificator.comment.post
  #     end
  #   end
  # end

  context 'when else notifications' do
    before do
      @notification = create(:notification, :from_else, to_id: recipient.id, from_id: sender.id)
    end

    describe 'GET /show' do
      it 'redirects to root' do
        get notifications_show_path(@notification)
        expect(response).to redirect_to root_path
      end
    end
  end
end
