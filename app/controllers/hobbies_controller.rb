class HobbiesController < ApplicationController

  def index
    #@hobby = Hobby.includes(:user).order("created_at DESC")
  end

  def new
    @hobby = Hobby.new
    @category_parent_array = ["--"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def get_category_children
    @category_children = Category.find(params[:parent_name]).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  def create
    @hobby = Hobby.new(hobby_params)
    unless @hobby.user_id == current_user.id
      redirect_to root_path
    end
    if @hobby.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def hobby_params
    params.require(:hobby).permit(:title, :release_date, :recommended, :synopsis).merge(user_id: current_user.id)
  end

end