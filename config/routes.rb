Rails.application.routes.draw do
  resource :session, only: %i(create)

  namespace :email_user do
    resources :registrations, only: %i(create update)
  end
end
