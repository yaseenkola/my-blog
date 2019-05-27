Rails.application.routes.draw do


  root to: 'pages#index'
  
  get 'welcome', to: 'welcome#index'
  

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :blogs do 
    member do
      get :toggle_status
    end
  end
  
  resources :amol361s do 
		member do 
			put :hide
		end
	end

	put "unhide_all_amol361" => "amol361s#unhide_all"


	resources :amol361s do 
		collection { post :import }
	end

	get "remove_all_amol361s" => "amol361s#remove_all"
  
end
