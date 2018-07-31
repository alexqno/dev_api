Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :coords, only: [:create]

  resource :jwt_auths, only: [:create]

  resources :users do
    resource :coords, only: [:show]
    resource :coord, only: [:create]
  end
end
