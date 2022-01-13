# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcomes', type: :request do
  describe 'GET /index' do
    it 'renders a successful response' do
      get '/welcome/index'
      expect(response).to be_successful
    end
  end
end
