Rails.application.routes.draw do
  resource :session, only: %i(create)

  namespace :admin do
    resources :users, only: %i(index show)
    resources :feedbacks, only: %i(index)
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

  resources :categories, only: %i(index create update) do
    post :sort, on: :collection
  end
  resource :user, only: %i(show update)
  resource :feedback, only: %i(create)
end
