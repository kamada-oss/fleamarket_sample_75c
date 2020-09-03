class PurchasesController < ApplicationController
  require 'payjp'

  def index
    user = User.find_by(id: current_user.id)
    @card = Card.find_by(user_id: current_user.id)
    @deliver = DeliverAddress.find_by(user_id: current_user.id)
    @item = Item.find()
    if @card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @default_card_information = customer.cards.retrieve(@card.card_id)
    end
    # card = Card.where(user_id: current_user.id).first
    # #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
    # if card.blank?
    #   #登録された情報がない場合にカード登録画面に移動
    #   redirect_to controller: "card", action: "new"
    # else
    #   Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    #   #保管した顧客IDでpayjpから情報取得
    #   customer = Payjp::Customer.retrieve(card.customer_id)
    #   #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
    #   @default_card_information = customer.cards.retrieve(card.card_id)
    # end
  end

  def pay #登録したカードで購入を確定する
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    # @purchase = Purchase.new(item_id: item.id, saler_id: saler.id, buyer_id: current_user.id)
    Payjp::Charge.create(
    :amount => 3000, #支払金額を入力（itemテーブル等に紐づけても良い）
    # :amount => @item.price,
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
      #この辺の他コードは関係ない部分なので省略してます
    ).merge(user_id: current_user.id)
  end
end
