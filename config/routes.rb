Rails.application.routes.draw do
  resources :users
  post "/auth/login", to: "authentication#login"
  resources :providers
  get "/providers/:material/:stock/:price/:date", to: "providers#filter"
  resources :markers
  get "/markers/:start_date/:end_date/", to: "markers#filter"
end