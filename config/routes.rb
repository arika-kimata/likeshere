Rails.application.routes.draw do

  get 'messages/new'
  devise_for :users
  resources :users, only: :show

  root 'hobbies#index'

  resources :hobbies do
    resources :messages, only: [:create]#, :destroy]
    mount ActionCable.server, at: '/cable'
    collection do
      get 'get_category_children', defaults: { format: 'json' }
      get 'get_category_grandchildren', defaults: { format: 'json' }
    end
    #member do
      #get 'get_category_children', defaults: { format: 'json' }
      #get 'get_category_grandchildren', defaults: { format: 'json' }
    #end
  end

end