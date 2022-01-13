# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { create(:user) }
  let(:order) { create(:order, user_id: user.id) }

  it 'is not valid without user' do
    order.user_id = nil
    expect(order).not_to be_valid
  end
end
