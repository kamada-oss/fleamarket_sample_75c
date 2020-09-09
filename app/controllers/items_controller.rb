class ItemsController < ApplicationController
  before_action :category_parent_array, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :show_all_instance, only: [:show, :edit, :update, :destroy]
  before_action :check_item_details, only: [:post_done, :update_done]
  before_action :category_map, only: [:edit, :update]
  before_action :set_ransack

  def index
    @items = Item.all
    @parents = Category.all.order("id ASC").limit(13)
  end

  def new
    @item = Item.new
    @item.item_images.new
    @parents = Category.all.order("id ASC").limit(13)
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to post_done_items_path
    else
      @item.item_images.new
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def post_done
    @item = Item.where(user_id: current_user.id).last
  end

  def edit
    @item.item_images.new
  end

  def update
    @item.touch
    if @item.update(item_params)
      redirect_to  update_done_items_path
    else
      flash.now[:alert] = '更新できませんでした'
      render :edit
    end
  end

  def update_done
    @item_update = Item.order("updated_at DESC").first
  end
  
  def destroy
    if @item.destroy
      redirect_to delete_done_items_path
    else
      redirect_to item_path(@item)
    end
  end

  def search_child
    respond_to do |format|
      format.html
      format.json do
        @children = Category.find(params[:parent_id]).children
      end
    end
  end

  def search_grandchild
    respond_to do |format|
      format.html
      format.json do
        @grandchildren = Category.find(params[:child_id]).children
      end
    end
  end

  # def purchase
  # end

  def select_category_index
    # カテゴリ名を取得するために@categoryにレコードをとってくる
    @category = Category.find_by(id: params[:id])

    # 親カテゴリーを選択していた場合の処理
    if @category.ancestry == nil
      # Categoryモデル内の親カテゴリーに紐づく孫カテゴリーのidを取得
      category = Category.find_by(id: params[:id]).indirect_ids
      # 孫カテゴリーに該当するitemsテーブルのレコードを入れるようの配列を用意
      @items = []
      # find_itemメソッドで処理
      find_item(category)

    # 孫カテゴリーを選択していた場合の処理
    elsif @category.ancestry.include?("/")
      # Categoryモデル内の親カテゴリーに紐づく孫カテゴリーのidを取得
      @items = Item.where(category_id: params[:id])

    # 子カテゴリーを選択していた場合の処理
    else
      category = Category.find_by(id: params[:id]).child_ids
      # 孫カテゴリーに該当するitemsテーブルのレコードを入れるようの配列を用意
      @items = []
      # find_itemメソッドで処理
      find_item(category)
    end
  end

  def search
    @search_items = Item.search(params[:keyword])
    @keyword = params[:keyword]
  end


  private

  def item_params
    params.require(:item).permit(
      :name, :text, :category_id, 
      :brand_name, :price, :condition, 
      :fee_burden, :prefecture, :handling_time, 
      item_images_attributes: [:id, :_destroy, :item_image]).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil).each do |parent|
    end
  end
  
  def check_item_details
    @item = Item.where(user_id: current_user.id).last
  end
  
  def show_all_instance
    @user = User.find(@item.user_id)
    @item_images = ItemImage.where(item_id: params[:id])
    @item_images_first = ItemImage.where(item_id: params[:id]).first
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

  def category_map
    grandchild = @item.category
    child = grandchild.parent
    if @category_id == 187 or @category_id == 465 or @category_id == 665 or @category_id == 777 or @category_id == 875 or @category_id == 962
    else
      @parent_array = []
      @parent_array << @item.category.parent.parent.name
      @parent_array << @item.category.parent.parent.id
    end
    @category_children_array = Category.where(ancestry: child.ancestry)
    @child_array = []
    @child_array << child.name
    @child_array << child.id

    @category_grandchildren_array = Category.where(ancestry: grandchild.ancestry)
    @grandchild_array = []
    @grandchild_array << grandchild.name
    @grandchild_array << grandchild.id
  end

end