class MypageController < ApplicationController
  before_action :redirect_to_login_when_not_signed_in

  def good_index
  end

  def item_exhibiting
    @items = Item.where(user_id: current_user.id)
  end

  def item_sold
  end

  def item_purchased
  end

  def edit_profile
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
end
