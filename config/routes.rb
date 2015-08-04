Rails.application.routes.draw do
  get 'users/show'

  root to: "users#show"
  get "/auth/:provider/callback", to: "sessions#create"
end
