Rails.application.routes.draw do

  root 'pages#home'

  resources :applicants do
    collection do
      get :apply
      post :next_step
      get :edit
      put :update
    end
  end

  get '/login' => 'sessions#new', as: :login
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy', as: :logout
  
  resources :funnels, only: [:index]
  
end
