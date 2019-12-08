require 'bcrypt'

class ApplicationController < ActionController::API
  def authenticate
    id = request.headers['x-user-id']
    auth_token = request.headers['x-user-token']
    user = User.find_by(id: id)
    if user && BCrypt::Password.new(user.auth_token) == auth_token
      return user
    else
      return false
    end
  end
end
