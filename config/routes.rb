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
  
end
