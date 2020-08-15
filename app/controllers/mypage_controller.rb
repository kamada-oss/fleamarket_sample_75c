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
  end

  def update_profile
    if current_user.update(user_pramas)
      redirect_to edit_profile_mypage_path
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
end
