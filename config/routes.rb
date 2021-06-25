Rails.application.routes.draw do

  get 'messages/new'
  devise_for :users
  resources :users, only: :show

  root 'hobbies#index'

  resources :hobbies do
    # コメント機能
    resources :messages, only: [:create, :destroy]
    # カテゴリー機能
    mount ActionCable.server, at: '/cable'
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
      get 'search'
    end
    member do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
  end

end