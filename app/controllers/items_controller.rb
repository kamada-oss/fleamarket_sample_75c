class ItemsController < ApplicationController

  def index
    @item = Item.all
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
    respond_to do |format|
      if @item.save
        params[:item_images][:image].each do |image|
          @item.item_images.create(image: image, item_id: @item.id)
        end
        format.html{redirect_to root_path}
      else
        @item.item_images.build
        format.html{render action: 'new'}
      end
    end
  end

  def show
  end

  def search
    respond_to do |format|
      format.html
      format.json do
        @children = Category.find(params[:parent_id]).children
      end
    end
  end

  def purchase
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :first_category_id, :second_category_id, :third_category_id, :size, :condition, :fee_burden, item_images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
