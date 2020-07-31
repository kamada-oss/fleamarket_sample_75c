class SignupController < ApplicationController
  def index
  end

  def registration_user_information
    @user = User.new
  end

  def registration_send_address
    @send_address = DeliverAddress.new
  end

  def create
    redirect_to done_signup_index_path
  end

  def done
  end

end
