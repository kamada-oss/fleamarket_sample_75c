class Items::SearchesController < ApplicationController
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
end
