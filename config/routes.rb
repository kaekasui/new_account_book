Rails.application.routes.draw do
  resource :session, only: %i(create)

  namespace :email_user do
    resources :registrations, only: %i(create) do
      get :regist
      patch :recreate, on: :collection
    end

    resources :passwords, only: %i(edit update) do
      post :send_mail, on: :collection
    end
  end

  resource :user, only: %i(show)
end
