Hyve4::Application.routes.draw do

scope "(:locale)", :locale => /en|de/ do

  resources :users do
    member do
      get :following, :followers
      put :create_project
    end
  end
  resources :projects do
    member do
      get :category
      put :update_category, :create_group, :update_group, :create_structure, :update_structure, :create_data, :update_email
    end
  end
  resources :structures do
    member do
      put :create_data, :update_dataval
    end
  end
  resources :pjattribs
  resources :sessions,        only: [:new, :create, :destroy]
  resources :postings,        only: [:create, :destroy]
  resources :relationships,   only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

  root to: 'users#new'
  match "/blog" => redirect("/blog/")
  match '/imprint', to: 'static_pages#imprint'
  match '/about', to: 'static_pages#about'
  match '/tour', to: 'static_pages#tour'
  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
  match '/email', to: 'static_pages#email'

end
end
