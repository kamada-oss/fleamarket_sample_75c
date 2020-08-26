class LikesController < ApplicationController
  before_action :set_item, only: [:create, :destroy]

  def index
    @likes = Like.where(user_id: current_user.id)
  end

  def create
    @like = Like.new(
      user_id: current_user.id, 
      item_id: @item.id
    )
    @like.save
  end

  def destroy
    @like = Like.find_by(
      user_id: current_user.id, 
      item_id: @item.id
    )
    @like.destroy
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end
end
