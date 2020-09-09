class CardController < ApplicationController

  require "payjp"
  before_action :set_card, only: [:new, :delete, :show]

  def new
    redirect_to action: "show" unless @card.nil?
  end

  def pay #payjpとCardのデータベース作成を実施します。
    Payjp.api_key = Rails.application.credentials[:payjp][:payjp_private_key]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      email: current_user.email, #なくてもOK
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      ) #念の為metadataにuser_idを入れましたがなくてもOK
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        item = Item.find(session[:item_id])
        redirect_to purchase_path(item)
      else
        redirect_to action: "new"
      end
    end
  end

  def delete #PayjpとCardデータベースを削除します
    if @card.present?
      Payjp.api_key = Rails.application.credentials[:payjp][:payjp_private_key]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      customer.delete
      @card.delete
    end
      item = Item.find(session[:item_id])
      redirect_to purchase_path(item)
  end

  def show #Cardのデータpayjpに送り情報を取り出します
    if @card.blank?
      redirect_to action: "new"
    else
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

  private
    def set_card
      @card = Card.where(user_id: current_user.id).first
    end
end