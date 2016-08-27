ReanimationLibraryCatalog::Application.routes.draw do

  scope "/catalog" do
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
    resources :donors
    resources :works
    resources :subjects
    resources :image_types
    resources :creator_types
    resources :creators
    resources :languages

    resources :items do
      collection do
    get :acquired
    get :need_images
    get :by_call_number
    get :recent
    get :by_branch
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
end
