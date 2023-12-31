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
  
  post "/bookings/:id/delayed", to: "bookings#delayed"
  post "/bookings/delete_all", to: "bookings#delete_all"
  post "/get_first_booking", to: "bookings#get_first_booking"
  get "/bookings/:id/state", to: "bookings#state"
  patch "/bookings/:id/channge_state", to: "bookings#channge_state"
 
  resources :bookings do 
    collection do 
      post "create_booking_material", to: "bookings#create_booking_material" 
      post "create_booking_maker", to: "bookings#create_booking_maker" 
      post "add_booking_material", to: "bookings#add_booking_material" 
    end 
  end 

  resources :provisions

  resources :fechas
  post "fechas/smallest_date", to: "fechas#smallest_date"
  post "fechas/delete_all", to: "fechas#delete_all"
end