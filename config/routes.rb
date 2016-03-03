Rails.application.routes.draw do
  resource :session, only: %i(create)
  get '/auth/:provider/callback', to: 'sessions#callback'

  namespace :admin do
    resources :users, only: %i(index show)
    resources :feedbacks, only: %i(index) do
      patch :check
    end
    resources :notices, only: %i(index create update destroy)
  end

  namespace :email_user do
    resources :registrations, only: %i(create) do
      get :regist
      patch :recreate, on: :collection
    end

    resources :passwords, only: %i(edit update) do
      post :send_mail, on: :collection
    end
  end

  resources :categories, except: %i(show new edit) do
    post :sort, on: :collection
    resources :breakdowns, only: %i(index create update destroy), module: :category
    resources :places, only: %i(index), module: :category
  end
  resources :notices, only: %i(index show)
  resources :places, only: %i(index create)
  resource :user, only: %i(show update)
  resource :feedback, only: %i(create)
end
