Rails.application.routes.draw do
  resources :books do
    post 'restore', on: :member
    resources :likes,    shallow: true, controller: 'votes', type: 'Like',    only: %i(create destroy)
    resources :dislikes, shallow: true, controller: 'votes', type: 'Dislike', only: %i(create destroy)

    resources :comments, shallow: true,                                       only: %i(index create destroy) do
      post 'restore', on: :member
    end
  end

  resources :borrowings

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_in/:token', to: 'sessions#show', as: :token_sign_in
  delete 'sign_out', to: 'sessions#destroy'

  root to: 'welcome#index'
end
