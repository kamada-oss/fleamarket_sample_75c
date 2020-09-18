class MypageController < ApplicationController
  require "payjp"
  before_action :set_user
  before_action :redirect_to_login_when_not_signed_in
  before_action :redirect_to_root_when_wrong_user
  before_action :delete_session_item_id, only: [:edit_payment]

  def good_index
    @likes = Like.where(user_id: @user.id)
  end

  def item_exhibiting
    @items = Item.where(user_id: @user.id, auction_status: 1)
  end

  def item_sold
    @items = Item.where(user_id: @user.id, auction_status: 2)
  end

  def item_purchased
    @purchases = Purchase.where(buyer_id: @user.id).includes(:item)
  end

  def edit_profile
  end

  def update_profile
    @user.update(user_params_introduction)
    # ニックネームと自己紹介にのみvalidateをかける
    unless @user.errors.include?(:nickname) or @user.errors.include?(:introduction)
      @user.save(validate: false)
      redirect_to edit_profile_mypage_path, notice: 'ユーザープロフィールを更新しました'
    else
      render :edit_profile
    end
  end

  def edit_address
    @send_address = DeliverAddress.find_by(user_id: @user.id)
  end

  def update_address
    @send_address = DeliverAddress.find_by(user_id: @user.id)
    if @send_address.update(deliver_address_params)
      redirect_to edit_address_mypage_path, notice: '発送元・お届け先住所を更新しました'
    else
      render :edit_address
    end
  end

  def edit_payment
    @card = Card.find_by(user_id: @user.id)
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

  def edit_email_password
  end

  def update_email_password
    if @user.update(user_params_email_password)
      sign_in(@user, bypass: true) if current_user.id == @user.id
      redirect_to edit_email_password_mypage_path, notice: 'メールアドレスとパスワードを更新しました'
    else
      if @user.password.empty? && @user.errors.exclude?(:email)
        @user.save(validate: false)
        redirect_to edit_email_password_mypage_path, notice: 'メールアドレスを更新しました'
      else
        render :edit_email_password
      end
    end
  end

  def edit_user_information
  end

  def logout
  end


  private
    def redirect_to_login_when_not_signed_in
      redirect_to new_user_session_path unless user_signed_in?
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params_introduction
      params.require(:user).permit(
        :nickname,
        :introduction
      )
    end

    def user_params_email_password
      params.require(:user).permit(
        :email,
        :password,
        :password_confirmation
      )
    end

    def validate_only_nickname_introduction
      @user.update(user_params_introduction)
      if @user.errors.include?(:nickname) or @user.errors.include?(:introduction)
        render :edit_profile
      end
    end

    def deliver_address_params
      params.require(:deliver_address).permit(
        :family_name,
        :first_name,
        :family_name_kana,
        :first_name_kana,
        :zip_code,
        :prefecture,
        :city,
        :address1,
        :address2,
        :phone_number
      )
    end

    def redirect_to_root_when_wrong_user
      redirect_to root_path unless @user == current_user
    end

    def delete_session_item_id
      # アイテム購入画面の遷移を防ぐ為、sessionを削除
      if session[:item_id].present?
        session[:item_id] = nil
      end
    end
end
