class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @hobbies = @user.hobbies
  end
  
end
