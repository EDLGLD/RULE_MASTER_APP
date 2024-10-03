Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :rules

  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  root 'home#top'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end
