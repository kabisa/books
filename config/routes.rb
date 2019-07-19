Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'sign_in', to: 'sessions#new', as: :signin
  post 'sign_in', to: 'sessions#create'
  get '/sign_in/:token', to: 'sessions#show', as: :token_sign_in

  root to: 'welcome#index'
end
