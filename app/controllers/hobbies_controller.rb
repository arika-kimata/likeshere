class HobbiesController < ApplicationController
  before_action :set_category, only: [:new, :create]#:edit, :update, :destroy]

  def index
    @hobby = Hobby.includes(:user).order("created_at DESC")
  end

  def new
    @hobby = Hobby.new
    @category_parent_array = ["---"]
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
    #binding.pry
    @hobby = Hobby.new(hobby_params)
    @hobby.user_id == current_user.id
    if @hobby.valid?
      @hobby.save
      Category.maltilevel_category_create(
        @hobby,
        params[:parent_id],
        params[:children_id],
        params[:grandchildren_id]
      )
      redirect_to root_path
    else
      @category_parent_array = ["---"]
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
      render :new
    end
  end

  def get_category_children
    @category_children = Category.find_by(name: "#{params[:parent_name]}", ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find("#{params[:child_id]}").children
  end

  private

  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def hobby_params
    params.require(:hobby).permit(:title, :release_date, :recommended, :synopsis, :category_id).merge(user_id: current_user.id)
  end

end