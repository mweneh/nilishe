Rails.application.routes.draw do

  # authentication routes
  post "/auth/create_account", to: "authentication#register_user"
  post "/auth/login", to: "authentication#login_user"

   # recipe routes
   post "/recipe/create", to: "recipe#create_recipe"
   put "/recipe/update/:id", to: "recipe#update_recipe"
   delete "/recipe/delete/:id", to: "recipe#delete_recipe"

   get "/recipe/all", to: "recipe#fetch_recipes"
   get "/recipe/all/:q", to: "recipe#search_recipes"
end