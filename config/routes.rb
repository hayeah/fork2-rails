Fork::Application.routes.draw do
  controller :sessions, :path => "auth" do
    get :not_registered
    post :logout
  end

  get '/auth/:provider', to: "sessions#new", as: "auth"
  get '/auth/:provider/callback', to: 'sessions#create'

  get '/login', to: "sessions#login", as: "login"

  # controller :api, :path => "api" do
  #   get :auth
  #   post :auth
  #   post :report_test
  # end

  resources :cohorts do
    member do
      get "checkin/:cohort_lesson_id", :action => :checkin
      match "checkin/:cohort_lesson_id", :via => [:post,:patch], :action => :do_checkin
    end
  end

  # resources :courses do
  #   resources :lessons
  # end

  # get '/admin', to: "admin#check_auth"

  controller :admin, :path => "admin" do
    get "/", :action => :index, :as => "admin_index"
    post :pretend_login, :as => "admin_pretend_login"
  end

  namespace :admin do
    resources :checkins do
      collection do
        get "unpublished"
        post "publish_all"
      end
    end
    # resources :users do
    #   collection do
    #     post "batch_add"
    #   end
    # end

    # resources :courses

    resources :cohorts do
      member do
        patch "update_users"
        patch "update_lessons"
        patch "link_discourse_users"
      end
    end
  end

  root "main#root"
end
