Rails.application.routes.draw do

  # authentication routes
  post "/auth/create_account", to: "authentication#register_user"
  post "/auth/login", to: "authentication#login_user"

end