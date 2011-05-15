Motoprieks::Application.routes.draw do
  get "login" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  resources :users
  resources :sessions
  resources :categories
  resources :images

  match 'code_image/:id' => 'images#code_image'
  get "destroy" => "posts#destroy", :as => "destroy"
  get "admin_category" => "posts#admin_category", :as => "admin_category"
  get "create_category" => "posts#create_category", :as => "create_category"
  get "edit_category" => "posts#edit_category", :as => "edit_category"
  resources :posts do
    resources :comments
  end
  resources :mains
  get "show_category" => "mains#show_category", :as => "show_category"
  root :to => "mains#index"
end
