class AuthenticationController < ApplicationController

  def login_user
    user = User.where(["username = :username OR email = :email",
                       {username: auth_params[:username], email: auth_params[:email]}] ).first
    if user && user.authenticate(auth_params[:pass])
      account_login(token: create_token(user))
    else
      account_login(failed: true)
    end
  end
  
  def register_user
    user = User.create(username: auth_params[:username], email: auth_params[:email], password: auth_params[:pass])
    user.valid? ? account_created(token: create_token(user)) : account_created(failed: true, errors: user.errors)
  end
  
    private
    # create JWT token with user data
  def create_token(user)
    # user information
    user_data = {
      username: user.username,
      role: user.u_type,
    }
    # jwt payload
    payload = {
      data: user_data,
      exp: Time.now.to_i + 6 * 3600
    }
    # return the token as a hash
    { authToken: encode_data(payload) }
  end

    def auth_params
      params.permit(:username, :email, :pass)
    end
  
    def account_created(failed: false, errors: nil, token: nil)
    app_response(status: failed ? :unprocessable_entity : :created,
                 message: failed ? "Account creation failed" : "Account created",
                 body: failed ? errors : token)
  end

  def account_login(failed: false, token: nil)
    app_response(status: failed ? :unprocessable_entity : :ok,
                 message: failed ? "We could not find your account" : "Login successful",
                 body: token)
  end
  
  private
  # get user data from token
  def user_data
    auth_header = request.headers['Authorization']
    token = auth_header ? auth_header.split(' ').last : nil.to_s
    decoded_info = decode_data(token)
    !!decoded_info ? decoded_info[0]["data"] : nil
  end

  # @api unauthorized user response
  def unauthorized_user
    app_response(status: :unauthorized, message: "You are not authorized to perform that operation")
  end

 # retrieve user data from DB
  def retrieve_user_info(username: user_data["username"])
    User.find_by(username: username)
  end
  end