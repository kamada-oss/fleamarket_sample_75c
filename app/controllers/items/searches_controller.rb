class Items::SearchesController < ApplicationController
  before_action :check_item_details, only: [:index, :post_done, :update_done]
  before_action :category_map, only: [:index, :edit, :update]
  before_action :set_ransack

  def index
    @items = @q.result(distinct: true)
    @keyword = (search_params[:name_cont])
  end

  private
  def set_ransack
    @q = Item.ransack(params[:q])
  end

  def search_params
    params.require(:q).permit(
      :sorts, :search_order, :name_cont,
      :brand_name_cont, :condition_eq, :fee_burden_eq,
      :category_id_eq, :prefecture_eq, :price_lteq, :price_gteq)
  end
  
  def check_item_details
    @item = Item.where(user_id: current_user.id).last
  end

  def category_map
    grandchild = @item.category
    child = grandchild.parent
    if @category_id == 187 or 
      @category_id == 465 or @category_id == 665 or
       @category_id == 777 or @category_id == 875 or @category_id == 962
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
