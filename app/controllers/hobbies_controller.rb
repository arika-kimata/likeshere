class HobbiesController < ApplicationController
  before_action :set_category, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_hobby, only: [:show, :edit, :update, :destroy, :search]
  before_action :session_user, only: [:edit, :update, :destroy]
  #before_action :move_to_index, except: [:index, :show, :search]

  def index
    # 情報の取得
    @hobbies = Hobby.includes(:user).order('created_at DESC')
  end

  def search
    #@hobbies = Hobby.search(params[:keyword])
  end

  def new
    @hobby = Hobby.new
    @category_parent_array = ['---']
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end
  end

  def create
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
      flash[:notice] = '投稿が完了しました。'
    else
      @category_parent_array = ['---']
      Category.where(ancestry: nil).each do |parent|
        @category_parent_array << parent.name
      end
      render :new
    end
  end

  def get_category_children
    @category_children = Category.find_by(name: params[:parent_name].to_s, ancestry: nil).children
  end

  def get_category_grandchildren
    @category_grandchildren = Category.find(params[:child_id].to_s).children
  end

  def show
    @category_grandchild = @hobby.category
    @category_child = @category_grandchild.parent
    @category_parent = @category_child.parent
    # メッセージモデルの記述
    @message = Message.new
    @messages = @hobby.messages.order('created_at DESC')
  end

  def edit
    @category_grandchild = @hobby.category
    @category_child = @category_grandchild.parent
    @category_parent = @category_child.parent
    # カテゴリー一覧を作成
    @category = Category.find(params[:id])
    # 紐づく孫カテゴリーの親（子カテゴリー）の一覧を配列で取得
    @category_children = @hobby.category.parent.parent.children
    # 紐づく孫カテゴリーの一覧を配列で取得
    @category_grandchildren = @hobby.category.parent.children
  end

  def update
    # 編集画面で選択された新しいカテゴリー
    @category_grandchild = Category.find(hobby_params[:category_id])
    @category_child = @category_grandchild.parent
    @category_parent = @category_child.parent
    if @hobby.update(hobby_params)
      category = Category.where(hoby_id: @hobby.id)
      category.destroy_all
      Category.maltilevel_category_create(
        @hobby,
        params[:parent_id],
        params[:children_id],
        params[:grandchildren_id]
      )
      redirect_to @hobby
      flash[:notice] = '投稿の編集が完了しました。'
    else
      @category_parent_array = Category.category_parent_array_create
      render :edit
    end
  end

  def destroy
    if @hobby.destroy
      redirect_to root_path
      flash[:notice] = '投稿を削除しました。'
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = '投稿の削除に失敗しました。'
    end
  end

  private

  def hobby_params
    params.require(:hobby).permit(:title, :release_date, :recommended, :synopsis, :category_id).merge(user_id: current_user.id)
  end

  def set_hobby
    @hobby = Hobby.find(params[:id])
  end

  def set_category
    @category_parent_array = Category.where(ancestry: nil)
  end

  def session_user
    redirect_to root_path if current_user.id != @hobby.user_id
  end

  #def move_to_index
    #unless user_signed_in?
      #redirect_to action: :index
    #end
  #end

end
