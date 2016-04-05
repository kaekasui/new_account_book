Rails.application.routes.draw do
  resource :session, only: %i(create)
  get '/auth/:provider/callback', to: 'sessions#callback'

  namespace :admin do
    resources :users, only: %i(index show) do
      resources :messages, only: %i(create), module: :user
      resources :feedbacks, only: %i(index), module: :user
    end
    resources :feedbacks, only: %i(index) do
      patch :check
    end
    resources :notices, only: %i(index create update destroy)
    resources :messages, only: %i(index update destroy) do
      post :send_mail
    end
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
  resources :messages, only: %i(index show)
  resources :notices, only: %i(index show)
  resources :places, only: %i(index create update destroy) do
    resources :categories, only: %i(index update destroy), module: :place
  end
  resources :records, only: %i(index new create update)

  resource :user, only: %i(show update) do
    patch :set_display
  end
  resource :feedback, only: %i(create)
  resource :mypage, only: %i(show), on: :collection
end
