class ItemsController < ApplicationController

  def index
    @item = Item.all
  end

  def new
    @parents = Category.all.order("id ASC").limit(13)
    @item = Item.new
    @item.item_images.build
  end

  def create
    @item = Item.new(item_parameter)
    respond_to do |format|
      if @item.save
        params[:item_images][:image].each do |image|
          @item.item_images.create(image: image, product_id: @product.id)
        end
        format.html{redirect_to root_path}
      else
        @item.item_images.build
        format.html{render action: 'new'}
      end
    end
  end

  def search
    respond_to do |format|
      format.html
      format.json do
        @children = Category.find(params[:parent_id]).children
      end
    end
  end

  private
  def item_parameter
    params.require(:item).permit(:name, :description, :first_category_id, :second_category_id, :third_category_id, :size, :item_status, :delivery_fee, product_images_attributes: [:image]).merge(user_id: current_user.id)
  end

end
