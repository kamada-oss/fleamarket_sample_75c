class ItemsController < ApplicationController
  before_action :category_parent_array, only: [:new, :create, :edit, :update]

  def index
    @item = Item.includes(:images).order('created_at DESC')
  end

  def new
    @item = Item.new
    @parents = Category.all.order("id ASC").limit(13)
    @item.item_images.build
    @item.build_shipping
    @item.build_brand
  end

  def create
    @item = Item.new(item_params)
    if @item.image.present?
      @item.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def show
  end
  
  def edit
  end

  def update
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
    params.require(:item).permit(:name, :explanation, :category_id, :parent_form, :child_form, :grandchild_form, :price, :size, :conditions, :fee_burdens, :areas, :handling_times, images_attributes: [:image]).merge(user_id: current_user.id)
  end

  def category_parent_array
    @category_parent_array = Category.where(ancestry: nil).each do |parent|
    end
  end
end
