class MypageController < ApplicationController
  before_action :redirect_to_login_when_not_signed_in

  def good_index
  end

  def item_exhibiting
    @items = Item.where(user_id: current_user.id)
  end

  def item_sold
    @items = Item.where(user_id: 50)
  end

  def item_purchased
    @items = Item.where(user_id: 50)
  end

  def edit_profile
    @user = current_user
  end

  def update_profile
    @user = current_user
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
  end

  def edit_payment
  end

  def edit_email_password
  end

  def edit_user_information
  end

  def logout
  end


  private
    def redirect_to_login_when_not_signed_in
      redirect_to new_user_session_path unless user_signed_in?
    end

    def user_params_introduction
      params.require(:user).permit(
        :nickname,
        :introduction
      )
    end

    def validate_only_nickname_introduction
      @user.update(user_params_introduction)
      if @user.errors.include?(:nickname) or @user.errors.include?(:introduction)
        render :edit_profile
      end
    end
end
