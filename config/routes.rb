Verkidn2014::Application.routes.draw do

  devise_for :users, skip: [:sessions, :registrations, :passwords]
  as :user do
    get 'login' => 'devise/sessions#new', :as => :new_user_session
    post 'login' => 'devise/sessions#create', :as => :user_session

    delete 'logout' => 'devise/sessions#destroy', :as => :destroy_user_session
    get 'logout' => 'devise/sessions#destroy'

    get 'register' => 'users/registrations#new', :as => :new_user_registration
    post 'register' => 'users/registrations#create', :as => :user_registration

    get 'user' => 'users/registrations#edit', :as => :edit_user_registration
    put 'register' => 'users/registrations#update'

    get 'reset' => 'devise/passwords#new', :as => :new_user_password
    get 'reset_password' => 'devise/passwords#edit', :as => :edit_user_password
    post 'reset' => 'devise/passwords#create', :as => :user_password
    put 'reset' => 'devise/passwords#update'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'assignments/assignments#index'


  resources :assignments, module: "assignments", only: [:index] do
    collection do
      get :all
    end
    resources :worklog
  end

  scope module: "manage" do
    resources :projects do
      resources :tasks do
        resources :assignments
        collection do
          get :open, to: :opened
          get :closed
        end
        post :close, on: :member
        post :open, on: :member
      end
    end
    get "projects/status/:status_id", action: :status, controller: :projects, as: :status_projects
  end
  
  resources :employees, module: "employees" do
    resources :worklog, only: [:index]
    resources :assignments, only: [:index]
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
