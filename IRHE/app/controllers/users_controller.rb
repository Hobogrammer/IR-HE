class UsersController < ApplicationController

  def index #user list? needed?
  end

  def show #page other users see when they go to a users page
  end

  def main #page the user sees for his/her account
    @texts = current_user.texts
  end

private
  def user_params
    params.require(:user).permit(:name, :provider, :avatar,:t_z, :uid)
  end
end
