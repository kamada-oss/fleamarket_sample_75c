require 'rails_helper'

describe SignupController do
  let(:user) { create(:user) }

  describe 'GET #index' do
    context 'ログインしている場合' do
      before do
        login user
        get :index
      end

      it 'トップページにリダイレクトされること' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログインしていない場合' do
      before do
        get :index
      end

      it 'index.html.erbに遷移すること' do
        get :index
        expect(response).to render_template :index
      end
    end
  end


  describe 'GET #registration_user_information' do
    context 'ログインしている場合' do
      before do
        login user
        get :registration_user_information
      end
      it 'トップページにリダイレクトされること' do
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログインしていない場合' do
      before do
        get :registration_user_information
      end
      it "registration_user_information.html.erbに遷移すること" do
        get :registration_user_information
        expect(response).to render_template :registration_user_information
      end
    end
  end 


  describe 'GET #registration_send_address' do
    context 'ログインしている場合' do
      before do
        login user
        get :registration_send_address
      end
      it 'トップページにリダイレクトされること' do
        expect(response).to redirect_to(root_path)
      end
    end
  end
end