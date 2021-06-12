class HobbyController < ApplicationController

  def index
    #@hobby = Hobby.includes(:user).order("created_at DESC")
  end
end
