class ItemsController < ApplicationController
  before_action :category_parent_array, only: [:new, :create, :edit, :update]
  before_action :check_item_details, only: [:post_done]
  before_action :set_item, only:[:destroy, :show]
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
    unless @item.brand_id.nil?
      @brand = Brand.find(@item.brand_id)
    end
  end

  def post_done
    @item = Item.where(user_id: 1).last
  end

  def update
    if item_params[:images_attributes].nil?
      flash.now[:alert] = '更新できませんでした【画像を1枚以上入れてください】'
      render :edit
    else
      exit_ids = []
      item_params[:images_attributes].each do |a,b|
        exit_ids << item_params[images_attributes].dig(:"#{a}", :id).to_i
      end
      ids = Image.where(item_id: params[:id]).map{|image| image.id}
      exit_ids_uniq = exit_ids.exit_ids_uniq
      delete__db = ids - exit_ids_uniq
      Image.where(id:delete__db).destroy_all
      @item.touch
    end
  end

  def destroy
    if @item.destroy
      redirect_to delete_done_items_path
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

  def purchase
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :brand_id, :price, :condition, :fee_burden, :prefecture, :handling_time, item_images_attributes: [:id, :item_image]).merge(user_id: 1)
  end

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil).each do |parent|
    end
  end
  
  def check_item_details
    @item = Item.where(user_id: 1).last
  end

  def set_item
    @item = Item.find(params[:id])
  end


end