class AuthenticationController < ApplicationController

    def login_user
      user = User.where(["username = :username OR email = :email",
                         {username: auth_params[:username], email: auth_params[:email]}] )
      user.first&.authenticate(auth_params[:pass])? account_login : account_login(failed: true)
    end
  
    def register_user
      user = User.create(username: auth_params[:username], email: auth_params[:email], password: auth_params[:pass])
      user.valid? ? account_created : account_created(failed: true, errors: user.errors)
    end
  
    private
    def auth_params
      params.permit(:username, :email, :pass)
    end
  
    def account_created(failed: false, errors: nil)
      app_response(status: failed ? :unprocessable_entity : :created,
                   message: failed ? "Account creation failed" : "Account created",
                   body: errors)
    end
  
    def account_login(failed: false)
      app_response(status: failed ? :unprocessable_entity : :ok,
                   message: failed ? "We could not find your account" : "Login successful")
    end
  
  
  end