# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let(:user) { create(:user) }

  let(:valid_attributes) do
    { title: 'Any title', address: 'Any Adress', description: 'random description',
      specie: 'Dog', post_type: 'Sale', price: 666, user_id: user.id, coord_x: 102.34, coord_y: 313.48 }
  end

  let(:invalid_attributes) do
    { title: '', address: 'Any Adress', description: 'random description',
      specie: 'Cat', post_type: 'Sale', price: 666, user_id: nil }
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Post.create! valid_attributes
      get posts_path
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      p = Post.create! valid_attributes
      get post_path(p)
      expect(response).to have_http_status(:success)
    end
  end

  context 'not signed' do
    describe 'GET /new' do
      it 'returns http success' do
        get new_post_path
        expect(response).to redirect_to posts_path
      end
    end
  end

  context 'when user signed in' do
    before do
      login_user user
    end

    describe 'GET /new' do
      it 'returns http success' do
        get new_post_path
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /edit' do
      it 'returns http success' do
        p = Post.create! valid_attributes
        get edit_post_path(p)
        expect(response).to have_http_status(:success)
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new post' do
          expect do
            post '/posts', params: { post: valid_attributes }
          end.to change(Post, :count).by(1)
        end

        it 'redirects to the index if success' do
          post '/posts', params: { post: valid_attributes }
          expect(response).to redirect_to(posts_path)
        end

        it 'redirects to the new if fail' do
          post '/posts', params: { post: invalid_attributes }
          expect(response).to render_template('new')
        end
      end
    end

    describe 'PATCH /update' do
      context 'with valid parameters' do
        let(:valid_update_attributes) do
          { title: 'Any update title', description: 'Any update description' }
        end

        it 'updates the requested post' do
          c = Post.create! valid_attributes
          patch post_path(c), params: { post: valid_update_attributes }
          c.reload
          expect(c.description).to eq('Any update description')
        end

        it 'redirects to the index if success' do
          c = Post.create! valid_attributes
          patch post_path(c), params: { post: valid_update_attributes }
          c.reload
          expect(response).to redirect_to(post_path(c))
        end
      end

      context 'with invalid parameters' do
        let(:invalid_update_attributes) do
          { title: 'AB', content: 'Any update content' }
        end

        it 'renders a successful response to index' do
          c = Post.create! valid_attributes
          patch post_path(c), params: { post: invalid_update_attributes }
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested post' do
        c = Post.create! valid_attributes
        expect do
          delete post_path(c)
        end.to change(Post, :count).by(-1)
      end

      it 'redirects to the index' do
        c = Post.create! valid_attributes
        delete post_path(c)
        expect(response).to redirect_to(posts_path)
      end
    end
  end
end
