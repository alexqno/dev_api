class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def contact_params
    params.require(:user).permit(:name, :birthdate)
  end
end
