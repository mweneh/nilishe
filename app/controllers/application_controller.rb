class ApplicationController < ActionController::API
    # jwt secret key
SECRET_KEY = ENV['JWT_SECRET']

  # JWT Encoding
  def encode_data(payload)
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  # JWT Decoding
  def decode_data(token)
    begin
      JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })
    rescue JWT::DecodeError => e
      nil
    end
  end

  def not_found(message)
    app_response(status: 404, message: message)
  end

  def app_response(status: 200, message: nil, body: nil)
  render json: {
     status: status,
     message: message,
     body: body
 }, status: status
end
 # authenticate user
 def is_authorized?
  !!user_data ? @user_info = retrieve_user_info : unauthorized_user
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
