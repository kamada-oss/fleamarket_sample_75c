class SignupController < ApplicationController
  before_action :redirect_to_root_when_signed_in

  def index
  end

  def registration_user_information
    @user = User.new
  end

  def registration_send_address
    sns_auth
    @user = User.new(user_params)
    if @user.valid?
      @send_address = DeliverAddress.new
      # 入力されたユーザー情報をsessionに保存
      session[:nickname]              = @user.nickname
      session[:email]                 = @user.email
      session[:password]              = params[:user][:password]
      session[:password_confirmation] = params[:user][:password_confirmation]
      session[:family_name]           = @user.family_name
      session[:first_name]            = @user.first_name
      session[:family_name_kana]      = @user.family_name_kana
      session[:first_name_kana]       = @user.first_name_kana
      session[:birthday]              = @user.birthday
    else
      render :registration_user_information
    end
  end

  def create
    @user = User.new(
    nickname:              session[:nickname],
    email:                 session[:email],  
    password:              session[:password],
    password_confirmation: session[:password_confirmation],
    family_name:           session[:family_name],
    first_name:            session[:first_name],
    family_name_kana:      session[:family_name_kana],
    first_name_kana:       session[:first_name_kana],
    birthday:              session[:birthday]
    )
    # ユーザー情報と送り先住所に問題がなければ保存する
    if @user.valid?
      @send_address = DeliverAddress.new(deliver_address_params)
      if @send_address.valid?
        @user.save
        @send_address.user_id = @user.id
        @send_address.save
        session[:id] = @user.id
        redirect_to done_signup_index_path
      else
      render :registration_send_address
      end
    else
     redirect_to done_signup_index_path
    end
  end

  def done
    sign_in User.find(session[:id]) unless user_signed_in?
  end

  private
    def user_params
      params.require(:user).permit(
        :nickname,
        :email,
        :password,
        :password_confirmation,
        :family_name,
        :first_name,
        :family_name_kana,
        :first_name_kana,
        :birthday,
      )
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

    def redirect_to_root_when_signed_in
      if user_signed_in?
        redirect_to root_path
      end
    end

    def sns_auth
      if params[:sns_auth] == 'true'
        pass = Devise.friendly_token
        params[:user][:password] = pass
        params[:user][:password_confirmation] = pass
      end
    end
end