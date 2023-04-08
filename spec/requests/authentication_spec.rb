require 'rails_helper'
require 'json'

RSpec.describe AuthenticationController,  type: :controller do

  describe "Controller has valid methods" do
    it { is_expected.to respond_to(:login_user) }
    it { is_expected.to respond_to(:register_user) }
  end

  # spec to test JWT encoding
  describe ApplicationController, type: :controller do
      # dummy user data
      user_data = { name: "rutubishi", type: "admin", age: 18 }
      payload = { data: user_data }
  
      describe "Controller has valid methods " do
        it { is_expected.to respond_to(:encode_data) }
        it { is_expected.to respond_to(:decode_data) }
      end
  
      it "should encode data into hashed JWT" do
        encoded_data = @controller.encode_data(payload)
        decoded_data = @controller.decode_data(encoded_data)
        puts payload
        data = decoded_data.first
        
        # expect(decoded_data["data"]).to be_a(Hash)
        expect(data["data"]["age"]).to eq(payload[:data][:age])
        expect(data["data"]["name"]).to eq(payload[:data][:name])
        expect(data["data"]["type"]).to eq(payload[:data][:type])
      end

  end
  # Specs to check whether login and create account operations
  describe "Authentication", type: :request do

    # define routes for authentication
    create_account = "/auth/create_account"
    login_account = "/auth/login"

    # valid random user properties
    username = "mamanilishe"
    email = "app@nilishe.com"
    password = "Complexity.!123"

    # define headers required when making requests
    headers = { 'ACCEPT' => "application/json" }

    it "handles account creation properly" do
      # no params
      post create_account, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)

      # provide username, email and password that are valid
      post create_account, params: { username: username, email: email, pass: password }, headers: headers
      expect(response).to have_http_status(:created)

      # provide invalid data
      post create_account, params: { username: "hi", email: "app", pass: "123456" }, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)

      # provide duplicate data
      post create_account, params: { username: username, email: email, pass: password }, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)

    end

    it "handles account sign in properly" do
      # create a user account
      User.create(username: username, email: email, password: password)

      # no params
      post login_account, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)

      # correct account details (username/password)
      post login_account, params: { username: username, pass: password }, headers: headers
      expect(response).to have_http_status(:ok)

      # correct details (email/password)
      post login_account, params: { email: email, pass: password }, headers: headers
      expect(response).to have_http_status(:ok)


    end

  end

end