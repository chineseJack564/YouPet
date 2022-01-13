# frozen_string_literal: true

require 'rails_helper'
require_relative '../support/devise'

RSpec.describe 'Comments', type: :request do
  let!(:posting) { FactoryBot.create(:post) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:valid_attributes) do
    { title: 'Any title', content: 'Any content', sender_id: user.id, post_id: posting.id }
  end

  let!(:invalid_attributes) do
    { title: 'A', content: 'Any content', sender_id: nil, post_id: nil }
  end

  context 'when user signed in' do
    before do
      login_user user
    end

    describe 'GET /edit' do
      it 'returns http success' do
        p = Comment.create! valid_attributes
        get edit_post_comment_path(p.post, p)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /destroy' do
      it 'returns http success' do
        p = Comment.create! valid_attributes
        expect do
          delete post_comment_path(p.post, p)
        end.to change(Comment, :count).by(-1)
      end
    end

    describe 'Post /create' do
      it 'success' do
        post "/posts/#{posting.id}/comments", params: { comment: valid_attributes }
        expect(response).to redirect_to post_path(posting)
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:valid_update_attributes) do
          { title: 'Any update title', content: 'Any update description' }
        end

        it 'updates the requested post' do
          c = FactoryBot.create(:comment)
          patch post_comment_path(c.post, c), params: { comment: valid_update_attributes }
          c.reload
          expect(c.content).to eq('Any update description')
        end
      end

      context 'with invalid parameters' do
        let(:invalid_update_attributes) do
          { title: '', content: 'Any update description' }
        end

        it 'not updates the requested post' do
          c = Comment.create! valid_attributes
          patch post_comment_path(c.post, c), params: { comment: invalid_update_attributes }
          c.reload
          expect(c.title).to eq('Any title')
        end
      end
    end
  end

  describe 'Post /create' do
    it 'success' do
      post "/posts/#{posting.id}/comments", params: { comment: valid_attributes }
      expect(response).to redirect_to root_path
    end
  end
end
