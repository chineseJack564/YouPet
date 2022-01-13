require 'rails_helper'

RSpec.describe "Errors", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/error/index"
      expect(response).to have_http_status(:success)
    end
  end

end
