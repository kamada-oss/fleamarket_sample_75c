class PurchasesController < ApplicationController
  require 'payjp'

  before_action :set_item, only: [:show, :pay]

  def show
    @card = Card.find_by(user_id: current_user.id)
    @deliver = DeliverAddress.find_by(user_id: current_user.id)
    session[:item_id] = @item.id
    if @card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:payjp_private_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
      @card_brand = @default_card_information.brand
      case @card_brand
      when "Visa"
        @card_src = "visa.png"
      when "JCB"
        @card_src = "jcb.png"
      when "MasterCard"
        @card_src = "master.png"
      when "American Express"
        @card_src = "amex.png"
      when "Diners Club"
        @card_src = "diners.png"
      end
    end
  end

  def pay #登録したカードで購入を確定する
    card = Card.where(user_id: current_user.id).first
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

  private
    def set_item
      @item = Item.find(params[:id])
    end
end
