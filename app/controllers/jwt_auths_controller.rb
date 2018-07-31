class JwtAuthsController < ApplicationController
  before_action :authenticate_user!

  def create
    secret = "mopa"
    payload = {user: current_user.name}
    token = JWT.encode payload, secret, 'HS256'
    render json: [token: token]
  end
end
