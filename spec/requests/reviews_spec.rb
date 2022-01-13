# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Reviews', type: :request do
  let!(:sender) { create(:user) }
  let!(:recipient) { create(:user) }

  let!(:valid_attributes) do
    { title: 'Any title', content: 'random description', score: '☆☆☆', anon: 0, sender_id: sender.id,
      recipient_id: recipient.id }
  end

  let!(:valid_attributes2) do
    { title: 'Any title', content: 'random update description', score: 0, anon: 0, recipient_id: recipient.id }
  end

  let!(:invalid_attributes) do
    { title: '', content: 'random description', score: 1 }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      login_user sender
      Review.create! valid_attributes
      get reviews_index_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      login_user sender
      get reviews_show_path(recipient.id)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get reviews_show_path(recipient.id)
      expect(response).to redirect_to root_path
    end
  end

  context 'when not signed in' do
    describe 'GET /new' do
      it 'returns' do
        p = Review.create! valid_attributes
        get reviews_new_path(p.recipient_id)
        expect(response).to redirect_to posts_path
      end
    end

    describe 'GET /new' do
      it 'returns' do
        login_user recipient
        p = Review.create! valid_attributes
        get reviews_new_path(p.recipient_id)
        expect(response).to redirect_to posts_path
      end
    end
  end

  context 'when user signed in' do
    before do
      login_user sender
    end

    describe 'GET /new' do
      it 'returns http success' do
        p = Review.create! valid_attributes
        get reviews_new_path(p.recipient_id)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /edit' do
      it 'returns http success' do
        p = Review.create! valid_attributes
        get reviews_edit_path(p)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'post /create' do
      it 'add one' do
        expect do
          post "/reviews/#{recipient.id}/new", params: valid_attributes
        end.to change(Review, :count).by(1)
      end

      it 'returns false' do
        post "/reviews/#{recipient.id}/new", params: { review: invalid_attributes }
        expect(response).to redirect_to users_show_path(recipient.id)
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:valid_update_attributes) do
          { title: 'Any title', content: 'Any update content' }
        end

        it 'redirects to the index if success' do
          c = Review.create! valid_attributes
          patch reviews_update_path(c), params: { review: valid_update_attributes }
          c.reload
          expect(response).to redirect_to(users_show_path(c.sender_id))
        end
      end

      context 'with invalid parameters' do
        let(:invalid_update_attributes) do
          { title: 'AB', content: 'Any update content' }
        end

        it 'renders a successful response to index' do
          c = Review.create! valid_attributes
          patch reviews_update_path(c), params: { review: invalid_update_attributes }
          expect(response).to redirect_to(users_show_path(c.sender_id))
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested review' do
        c = Review.create! valid_attributes
        expect do
          delete reviews_delete_path(c)
        end.to change(Review, :count).by(-1)
      end

      it 'redirects to the recipient' do
        c = Review.create! valid_attributes
        delete reviews_delete_path(c)
        expect(response).to redirect_to(users_show_path(c.recipient))
      end
    end
  end
end
