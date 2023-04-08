class ApplicationController < ActionController::API
    # jwt secret key
SECRET_KEY = ENV['JWT_SECRET']
end
