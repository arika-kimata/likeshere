Rails.application.routes.draw do
  devise_for :users

  root 'hobby#index'

end