Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  resources :users
  post "/auth/login", to: "authentication#login"
  resources :providers do 
    collection do 
      post 'filter', to: 'providers#filter'
    end 
  end
  resources :makers do
    collection do 
      post 'filter', to: 'makers#filter'
    end 
  end 
 
  resources :bookings do 
    collection do 
      post "create_booking_material", to: "bookings#create_booking_material" 
      post "create_booking_maker", to: "bookings#create_booking_maker" 
    end 
  end 

  resources :provisions

  resources :fechas do
    get 'smallest_date', on: :member
  end

end