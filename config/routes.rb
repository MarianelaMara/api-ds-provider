Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  resources :users
  post "/auth/login", to: "authentication#login"
  resources :providers do 
    collection do 
      get 'filter', to: 'providers#filter'
    end 
  end
  resources :makers do
    collection do 
      get 'filter', to: 'makers#filter'
    end 
  end 

  resources :bookings
end