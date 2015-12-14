Rails.application.routes.draw do
  resource :session, only: %i(create)

  namespace :email_user do
    resources :registrations, only: %i(create update) do
      patch :recreate, on: :collection
    end

    resources :passwords, only: %i(edit update) do
      post :send_mail, on: :collection
    end
  end

  resources :users, only: %i(show)
end
