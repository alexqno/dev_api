class CoordsController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :set_user
  before_action :access_verify

  def show
    render json: @user.coords
  end

  def create
    @user.coords << Coord.new(coord_params)

    if @user.save
      render json: @user.coords, status: :created, location: user_coords_url(@user)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
  def access_verify
    test = false
    errors = nil
    begin
      jwt_authenticate
      test = true
    rescue => ex
      errors = ex.message
    end
    begin
      authenticate_user
      test = true
    rescue => ex
      errors = ex.message
    end
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> #{test}"

    if !test
      logger.error errors
    end
  end

  def jwt_authenticate
    secret = "mopa"
    authenticate_or_request_with_http_token do |token, options|
      JWT.decode token, secret, true, { algorithm: 'HS256' }
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    if params[:user_id]
      @user = User.find(params[:user_id])
    elsif params[:user_email]
      @user = User.find_by(email: params[:user_email])
    end
  end

  def coord_params
    params.require(:coord).permit(:latitude, :longitude, :user_id, :user_email)
  end
end
