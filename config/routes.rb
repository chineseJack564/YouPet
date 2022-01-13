# frozen_string_literal: true

Rails.application.routes.draw do
  get 'error/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # Create
  # get 'notifications/new', to: 'notifications#new', as: 'notifications_new'

  # Read
  get 'notifications/show/:id', to: 'notifications#show', as: 'notifications_show'
  get 'notifications/index'

  # Delete
  delete 'notifications/:id', to: 'notifications#delete', as: 'notifications_delete'

  # Create
  get 'reviews/:recipient_id/new', to: 'reviews#new', as: 'reviews_new'
  post 'reviews/:recipient_id/new', to: 'reviews#create', as: 'reviews_create'

  # Read
  # get 'reviews/index', to: 'reviews#index', as: 'reviews_index'
  # get 'reviews/:id', to: 'reviews#show', as: 'reviews_show'
  get 'reviews/:user_id', to: 'reviews#show', as: 'reviews_show'

  # Edit
  get 'reviews/:id/edit', to: 'reviews#edit', as: 'reviews_edit'
  patch 'reviews/:id', to: 'reviews#update', as: 'reviews_update'

  # Delete
  delete 'reviews/:id', to: 'reviews#delete', as: 'reviews_delete'

  # Reply
  # Create
  # get 'replies/new', as: 'replies_new'
  # post 'replies', to: 'replies#create'

  # Read
  # get 'replies/index', as: 'replies_index'
  # get 'replies/:id', to: 'replies#show', as: 'replies_show'

  # Edit
  # get 'replies/:id/edit', to: 'replies#edit', as: 'replies_edit'
  # patch 'replies/:id', to: 'replies#update', as: 'replies_update'

  # Delete
  # delete 'replies/:id', to: 'replies#delete', as: 'replies_delete'

  resources :posts do
    resources :orders
  end

  get 'posts/new'
  get 'posts/create'
  get 'posts/show'
  get 'posts/delete'
  get 'posts/edit'

  resources :posts do
    member do
      get :accept_order
      get :reject_order
    end
    resources :comments
  end

  resources :comments do
    resources :replies
  end

  # # create
  # get 'comments/new', as: 'comments_new'
  # post 'comments', to: 'comments#create'

  # # read
  # get 'comments/index', as: 'comments_index'
  # get 'comments/:id', to: 'comments#show', as: 'comments_show'

  # # Update
  # get 'comments/:id/edit', to: 'comments#edit', as: 'comments_edit'
  # patch 'comments/:id', to: 'comments#update', as: 'comments_update'

  # # Delete
  # delete 'comments/:id', to: 'comments#delete', as: 'comments_delete'

  get 'welcome/index', as: 'home'
  root 'welcome#index'

  ## USERS

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  },
                     path: '',
                     path_names: {
                       sign_in: 'login',
                       sign_out: 'logout',
                       sign_up: 'register'
                     }


  # Show
  get 'users/:id', to: 'users#show', as: 'users_show'

  ## MESSAGES

  # Read Create
  get 'messages/from_:sender_id/to_:recipient_id', to: 'messages#show', as: 'messages_show'
  post 'messages/from_:sender_id/to_:recipient_id', to: 'messages#create'

  # # Update
  # get 'messages/:id/edit', to: 'messages#edit', as: 'messages_edit'
  # patch 'messages/:id', to: 'messages#update', as: 'messages_update'

  # Delete
  # delete 'messages/:id', to: 'messages#delete', as: 'messages_delete'

  get 'chats/create/from_:sender_id/to_:recipient_id', to: 'chats#create', as: 'chats_create'
  get 'chats/show/:sender_id/:recipient_id', to: 'chats#show', as: 'chats_show'

  resources :chats do
    post :update_c, on: :collection
  end

  resources :notifications do
    post :update_n, on: :collection
  end

  post 'users/darkmode', to: 'users#darkmode', as: 'users_darkmode'

  resources :welcome do
    resources :messages
  end

  if Rails.env.production?
    get '/404', :to => 'application#page_not_found', as: 'error'
    get '/500', :to => 'application#page_not_found'
  end

  get "*path", to: 'application#page_not_found', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
