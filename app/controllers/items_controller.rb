class ItemsController < ApplicationController
  before_action :category_parent_array, only: [:new, :create, :edit, :update]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :show_all_instance, only: [:show, :edit, :update, :destroy]
  before_action :check_item_details, only: [:post_done, :update_done]
  before_action :category_map, only: [:edit, :update]

  def index
    @items = Item.all
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
    @item = Item.find(params[:id])
  end
  
  def post_done
    @item = Item.where(user_id: 1).last
  end

  
  def edit
  end

  def update
    if item_params[:item_images_attributes].nil?
      flash.now[:alert] = '更新できませんでした【画像を1枚以上入れてください】'
      render :edit
    else
      exit_ids = []
      item_params[:item_images_attributes].each do |a,b|
        exit_ids << item_params[:item_images_attributes].dig(:"#{a}", :id).to_i
      end
      ids = ItemImage.where(item_id: params[:id]).map{|item_image| item_image.id}
      exit_ids_uniq = exit_ids.uniq
      delete__db = ids - exit_ids
      ItemImage.where(id:delete__db).destroy_all
      @item.touch
      if @item.update(item_params)
        redirect_to update_done_items_path
      else
        flash.now[:alert] = '更新できませんでした'
        render :edit
      end
    end
  end

  def update_done
    @item_update = Item.order("updated_at DESC").first
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

  def purchase
  end


  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :brand_id, :price, :condition, :fee_burden, :prefecture, :handling_time, item_images_attributes: [:id, :_destroy, :item_image]).merge(user_id: 1)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil).each do |parent|
    end
  end
  
  def check_item_details
    @item = Item.where(user_id: 1).last
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
    if @category_id == 46 or @category_id == 74 or @category_id == 134 or @category_id == 142 or @category_id == 147 or @category_id == 150 or @category_id == 158
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