ReanimationLibraryCatalog::Application.routes.draw do

  scope "/catalog" do
    devise_for :users

    as :user do
      delete "/logout" => "devise/sessions#destroy", as: 'logout'
    end

    resources :users

    get 'search' => 'search#new', :as => :search
    get 'advanced_search' => 'search#new', :as => :advanced_search, :advanced => 'true'
    get 'search_results' => 'search#show', :as => :search_results
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
    resources :digital_asset_ingests
    resources :log_entries
    get 'dashboard' => 'admin_dashboard#index', :as => :admin_dashboard
    get '/' => 'items#index'
    get '/:controller(/:action(/:id))'
    root 'items#index'

  end
end
