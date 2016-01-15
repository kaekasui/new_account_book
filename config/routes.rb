Rails.application.routes.draw do
  resource :session, only: %i(create)

  namespace :admin do
    resources :users, only: %i(index)
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

  resource :user, only: %i(show)
  resource :feedback, only: %i(create)
end
