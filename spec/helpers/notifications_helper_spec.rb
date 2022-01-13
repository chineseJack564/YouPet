# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the NotificationsHelper. For example:
#
# describe NotificationsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe NotificationsHelper, type: :helper do
  let!(:r) { create(:notification, :from_review) }
  let!(:o) { create(:notification, :from_order) }
  let!(:m) { create(:notification, :from_message) }

  describe 'helper' do
    it 'do review' do
      expect(try_deleted_content(r)).to eq(r.notificator.content)
    end

    it 'do order' do
      expect(try_deleted_content(o)).to eq(o.notificator.status)
    end

    it 'do message' do
      expect(try_deleted_content(m)).to eq(m.notificator.body)
    end
  end
end
