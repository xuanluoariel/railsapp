Rails.application.routes.draw do  
  resources :occupant_categories
  devise_for :users
  resources :basics do
    collection do
      post 'update_zone'
      get 'edit'
    end
    resources :space_categories do
      collection do
        post 'update_space_category'
        post 'update_occupant'
        get 'edit'
      end
      resources :occupants
    end
    resources :spaces do
      collection { post :import }
    end
    resources :occupant_categories
  end
  root 'pages#welcome'
  match ':controller(/:action(/:id(.:format)))', :via => :all
  match '/help',    to: 'pages#about',    via: 'get'
  match '/load',    to: 'pages#about',            via: 'get'  
end
