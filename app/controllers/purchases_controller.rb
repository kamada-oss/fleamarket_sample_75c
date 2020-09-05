class PurchasesController < ApplicationController
  require 'payjp'

  def index
    user = User.find_by(id: current_user.id)
    @item = Item.find(params[:id])
    @card = Card.find_by(user_id: current_user.id)
    @deliver = DeliverAddress.find_by(user_id: current_user.id)
    if @card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:payjp_private_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay #登録したカードで購入を確定する
    # @item = Item.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = Rails.application.credentials[:payjp][:payjp_private_key]
    # purchase = Purchase.new(item_id: item.id, saler_id: saler.id, buyer_id: buyer.id)
    Payjp::Charge.create(
    :amount => 3000,
    # amount: @item.price,
    :customer => card.customer_id, #顧客ID
    :currency => 'jpy', #日本円
  )
  redirect_to action: 'done' #完了画面に移動
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :text,
      :price,
    ).merge(user_id: current_user.id)
  end
end
