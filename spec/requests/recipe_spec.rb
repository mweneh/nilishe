require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  include UserTestData, RoutesTestData, RecipeTestData
  # check for valid methods in the controller
  describe RecipeController, type: :controller do

    # check for existence of methods in the controller
    it { is_expected.to respond_to(:create_recipe) }
    it { is_expected.to respond_to(:update_recipe) }
    it { is_expected.to respond_to(:delete_recipe) }

  end

     # display all the recipes in database / search for a meal
     it "lists recipes" do

      def get_auth_token
        user = User.create(username: 'test_user', email: 'test_user@example.com', password: 'password')
        post '/auth/login', params: { email: user.email, password: user.password }
        JSON.parse(response.body)['auth_token']
      end
      
      
      
      user = dummy_user
      # create two recipes
      dummy_recipe(user: user)
      dummy_recipe(user: user)

      # set the authentication token in the request headers
token = get_auth_token
headers = {
  'Authorization': "Bearer #{token}",
  'Content-Type': 'application/json'
}

# view all recipes
get r_recipe[3], headers: headers
expect(response).to have_http_status(:ok)

# search for recipe
get r_recipe(q: 'ugali')[4], headers: headers
expect(response).to have_http_status(:ok)

      
    end

  describe "Recipe controller requests" do

    it "creates, updates and deletes recipes appropriately" do
      # create a new user
      user = User.create(username: user_credentials[:username], email: user_credentials[:email],
                  password: user_credentials[:pass])

      # login user
      post r_auth[1], params: user_credentials , headers:headers
      auth_token = JSON.parse(response.body)["body"]["authToken"]
      token_header = headers_with_token(auth_token)

      # create recipe with valid data
      post r_recipe[0], params: recipe_data, headers: token_header
      expect(response).to have_http_status(:created)
      @recipe_id = JSON.parse(response.body)["body"]["recipe"]["id"]

      # create recipe with invalid data
      post r_recipe[0], params: invalid_recipe_data, headers: token_header
      expect(response).to have_http_status(:unprocessable_entity)

      # update recipe with valid data
      put r_recipe(rid: @recipe_id)[1], params: recipe_data, headers: token_header
      expect(response).to have_http_status(:ok)

      # update recipe with invalid data
      put r_recipe(rid: @recipe_id)[1], params: invalid_recipe_data, headers: token_header
      expect(response).to have_http_status(:unprocessable_entity)

      # delete recipe
      delete r_recipe(rid: @recipe_id)[2], headers: token_header
      expect(response).to have_http_status(:ok)

      # delete recipe with invalid id
      delete r_recipe(rid: @recipe_id)[2], headers: token_header
      expect(response).to have_http_status(:unprocessable_entity)

    end
    

  end
  
end
