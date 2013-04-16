StacksocialInt::Application.routes.draw do

  root :to => 'home#index'

  match '/auth/:provider/callback', to: 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  match '/hi' => 'sessions#new', :as => :login
  match '/bye' => 'sessions#destroy', :as => :logout

  match '/api/user/:id' => 'home#user_detail'

end
