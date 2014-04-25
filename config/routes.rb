Fork::Application.routes.draw do
  get '/auth/:provider', to: "sessions#new", as: "auth"
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/login', to: "sessions#login", as: "login"

  controller :api, :path => "api" do
    get :auth
    post :auth
  end

  resources :cohorts do
    resources :lessons do
      resource :checkin
    end
  end

  resources :courses do
    resources :lessons
  end

  namespace :admin do
    resources :users do
      collection do
        post "batch_add"
      end
    end

    resources :courses
    resources :cohorts do
      member do
        patch "add_users"
      end
    end
  end

  root "main#root"
end
