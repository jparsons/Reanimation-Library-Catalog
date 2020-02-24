Rails.application.routes.draw do

  # search 'search', :controller=>'search', :action=>'new'
  # advanced_search 'advanced_search', :controller=>'search', :action=>'new', :advanced => 'true'
  #
  #
  # search_results 'search_results', :controller=>'search', :action=>'show'

  devise_for :users, path: '', path_names: {
      sign_in: 'login',
      sign_out: 'logout',
    }

  resources :exhibitions

  resources :vendors

  resources :digital_assets, :collection => { :most_recent => :get }

  resources :works

  resources :subjects

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

  # signup 'signup', :controller => 'users', :action => 'new'
  # logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  # login 'login', :controller => 'user_sessions', :action => 'new'
  resources :user_sessions

  resources :digital_asset_ingests

  resources :users

  resources :log_entries

  # admin_dashboard 'dashboard', :controller=>'admin_dashboard', :action=>"index"


  root 'items#index'


end
