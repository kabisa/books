Rails.application.routes.draw do
  resources :books do
    post 'restore', on: :member
    resources :likes, shallow: true
    resources :dislikes, shallow: true
  end

  resources :ebooks, controller: 'books', type: 'Ebook'
  resources :printed_books, controller: 'books', type: 'PrintedBook'


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_in/:token', to: 'sessions#show', as: :token_sign_in
  delete 'sign_out', to: 'sessions#destroy'

  resources :borrowings

  root to: 'welcome#index'
end
