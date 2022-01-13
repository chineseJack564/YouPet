# frozen_string_literal: true

require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the WelcomeHelper. For example:
#
# describe WelcomeHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe WelcomeHelper, type: :helper do
  let!(:user) { create(:user) }

  describe 'user image' do
    it 'is default' do
      expect(include_image(user)).to eq('<img class="avatar" src="/default-user.png" />')
    end
  end
end
