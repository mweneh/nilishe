require 'rails_helper'

RSpec.describe AuthenticationController,  type: :controller do
  include UserTestData, RoutesTestData

  describe "Controller has valid methods" do
    it { is_expected.to respond_to(:login_user) }
    it { is_expected.to respond_to(:register_user) }
  end

  # Specs to check whether login and create account operations
  describe "Authentication", type: :request do

    # define headers required when making requests
    headers = { 'ACCEPT' => "application/json" }

    it "handles account creation properly" do
      # create account route
      create_account = r_auth[0]

      # no params
      post create_account, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)

      # provide username, email and password that are valid
      post create_account, params: user_credentials, headers: headers
      expect(response).to have_http_status(:created)

      # provide invalid data
      post create_account, params: invalid_user_credentials, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)

      # provide duplicate data
      post create_account, params: user_credentials, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)

    end

    it "handles account sign in properly" do

      # login account URL
      login_account = r_auth[1]

      # create a user account
      User.create(username: user_credentials[:username], email: user_credentials[:email],
                  password: user_credentials[:pass])

      # no params
      post login_account, headers: headers
      expect(response).to have_http_status(:unprocessable_entity)

      # correct account details (username/password)
      post login_account, params: { username: user_credentials[:username],
                                    pass: user_credentials[:pass] }, headers: headers
      expect(response).to have_http_status(:ok)

      # correct details (email/password)
      post login_account, params: { email: user_credentials[:email], pass: user_credentials[:pass] }, headers: headers
      expect(response).to have_http_status(:ok)


    end

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
      decoded_data = @controller.decode_data(encoded_data)[0]
      expect(decoded_data["data"]["age"]).to eq(payload[:data][:age])
      expect(decoded_data["data"]["name"]).to eq(payload[:data][:name])
      expect(decoded_data["data"]["type"]).to eq(payload[:data][:type])
    end

  end

end