class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :basic_auth, if: :production?
  before_action :set_category
  before_action :set_ransack

  protected

  def set_category
    @parents = Category.limit(13)
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def production?
    Rails.env.production?
  end

  def set_ransack
    @q = Item.ransack(params[:q])
  end
end

