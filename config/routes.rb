ReanimationLibraryCatalog::Application.routes.draw do
  match 'search' => 'search#new', :as => :search
  match 'advanced_search' => 'search#new', :as => :advanced_search, :advanced => 'true'
  match 'search_results' => 'search#show', :as => :search_results
  resources :exhibitions
  resources :vendors
  resources :digital_assets do
    collection do
  get :most_recent
  end
  
  
  end

  resources :works
  resources :subjects
  resources :items do
    collection do
  get :acquired
  get :need_images
  get :by_call_number
  get :recent
  end
  
  
  end

  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'login' => 'user_sessions#new', :as => :login
  resources :user_sessions
  resources :digital_asset_ingests
  resources :users
  resources :log_entries
  match 'dashboard' => 'admin_dashboard#index', :as => :admin_dashboard
  match '/' => 'items#index'
  match 'root' => 'items#index'
  match '/:controller(/:action(/:id))'
end
