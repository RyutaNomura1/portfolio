Rails.application.routes.draw do
  root 'posts#index'
  get '/login', to: 'sessions#new'
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/top", to: "static_pages#top"
  # helpfulの作成と削除
  post "/answers/:answer_id//helpful", to: "helpfuls#create", as: "create_helpful"
  delete "/answers/:answer_id/helpful", to: "helpfuls#destroy", as: "destroy_helpful"
  
  resources :users, except: [:index]
  resources :posts, except: [:show] do
    resources :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  resources :questions, except: [:index] do
    resources :answers, only: [:create, :destroy]
  end
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
