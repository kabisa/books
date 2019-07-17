Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'sign_in', to: 'sessions#new', as: :signin

  root to: 'welcome#index'
end
