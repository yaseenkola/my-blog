Rails.application.routes.draw do


  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   root to: 'welcome#index'
  
  resources :blogs do 
    member do
      get :toggle_status
    end
  end
  
end
