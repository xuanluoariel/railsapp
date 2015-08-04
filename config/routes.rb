Rails.application.routes.draw do  
  
  resources :occupant_categories
  resources :basics, path_names: { show: 'simulate' }
  resources :basics do
    collection do
      post 'update_zone'
      post 'update_building'
      post 'update_space_type'
      post 'continue_session'
      post 'new'
      post 'simulate_input'
      post 'write_xml'
      post 'display_result'
      post 'download_files'
      get 'edit'
    end
    resources :space_categories do
      collection do
        post 'create_new'
        post 'update_space_category'
        post 'update_space_category_index'
        post 'update_occupant'
        post 'update_meeting'
        post 'check_percent'
        post 'cancel_add'
        get 'edit'
      end
      resources :occupants
      resources :meetings
    end
    resources :spaces do
      collection { post :import }
    end
    resources :occupant_categories do
      collection do
        post 'create_occupant_category'
        post 'create_occupant_category_index'
        post 'update_occupant_category'
        get 'edit'
      end
    end
    
  end
  root 'pages#welcome'
  match ':controller(/:action(/:id(.:format)))', :via => :all 
end
