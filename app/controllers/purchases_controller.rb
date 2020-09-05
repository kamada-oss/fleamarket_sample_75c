class PurchasesController < ApplicationController
  require 'payjp'

  def show
    user = User.find_by(id: current_user.id)
    @item = Item.find(params[:id])
    @card = Card.find_by(user_id: current_user.id)
    @deliver = DeliverAddress.find_by(user_id: current_user.id)
    session[:item_id] = @item.id
    if @card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:payjp_private_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def pay #登録したカードで購入を確定する
    card = Card.where(user_id: current_user.id).first
    @item = Item.find(params[:id])
    @item.update( auction_status: 2)
    Payjp.api_key = Rails.application.credentials[:payjp][:payjp_private_key]
    @purchase = Purchase.new(item_id: @item.id, saler_id: @item.user.id, buyer_id: current_user.id)
    @purchase.save
    Payjp::Charge.create(
    :amount => @item.price,
    :customer => card.customer_id,
    :currency => 'jpy',
  )
  redirect_to action: 'done' #完了画面に移動
  end

end
