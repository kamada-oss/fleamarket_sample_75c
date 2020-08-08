require 'rails_helper'
describe User do
  describe '#create' do
    it 'nickname, email, password, password_confirmation, family_name, first_name, family_name_kana, first_name_kana, birthdayがあれば登録できること' do
      user = build(:user)
      expect(user).to be_valid
    end

    # nickname
    it 'nicknameがない場合は登録できないこと' do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end

    it 'nicknameが20文字以下の場合は登録できること' do
      user = build(:user, nickname: 'a'*20)
      user.valid?
      expect(user).to be_valid
    end

    it 'nicknameが21文字以上の場合は登録できないこと' do
      user = build(:user, nickname: 'a'*21)
      user.valid?
      expect(user.errors[:nickname]).to include("は20文字以内で入力してください")
    end
   
    # email
    it 'emailがない場合は登録できないこと' do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end

    it '重複したemailが存在する場合は登録できないこと' do
      user = create(:user)
      another_user = build(:user, email: 'aaa@aaa.com')
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end

    it 'emailのフォーマットが不適切な場合は登録できないこと' do
      user = build(:user, email: 'aaa@aaa')
      user.valid?
      expect(user.errors[:email]).to include("のフォーマットが不適切です")
    end

    # password
    it 'passwordがない場合は登録できないこと' do
      user = build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it 'passwordが6文字以下の場合は登録できないこと' do
      user = build(:user, password: 'a'*6)
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it 'passwordが129文字以上の場合は登録できないこと' do
      user = build(:user, password: 'a'*129)
      user.valid?
      expect(user.errors[:password]).to include("は128文字以内で入力してください")
    end

    # password_confirmation
    it 'password_confirmationがない場合は登録できないこと' do
      user = build(:user, password_confirmation: nil)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("を入力してください")
    end

    it 'password_confirmationが6文字以下の場合は登録できないこと' do
      user = build(:user, password_confirmation: 'a'*6)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("は7文字以上で入力してください")
    end

    it 'password_confirmationが129文字以上の場合は登録できないこと' do
      user = build(:user, password_confirmation: 'a'*129)
      user.valid?
      expect(user.errors[:password_confirmation]).to include("は128文字以内で入力してください")
    end

    # famlily_name
    it 'family_nameがない場合は登録できないこと' do
      user = build(:user, family_name: nil)
      user.valid?
      expect(user.errors[:family_name]).to include("を入力してください")
    end

    it 'family_nameが36文字以上の場合は登録できないこと' do
      user = build(:user, family_name: 'a'*36)
      user.valid?
      expect(user.errors[:family_name]).to include("は35文字以内で入力してください")
    end

    it 'family_nameが半角の場合は登録できないこと' do
      user = build(:user, family_name: 'ﾃｽﾄ')
      user.valid?
      expect(user.errors[:family_name]).to include("は全角で入力して下さい")
    end

    # first_name
    it 'first_nameがない場合は登録できないこと' do
      user = build(:user, first_name: nil)
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください")
    end

    it 'first_nameが36文字以上の場合は登録できないこと' do
      user = build(:user, first_name: 'a'*36)
      user.valid?
      expect(user.errors[:first_name]).to include("は35文字以内で入力してください")
    end

    it 'first_nameが半角の場合は登録できないこと' do
      user = build(:user, first_name: 'ﾃｽﾄ')
      user.valid?
      expect(user.errors[:first_name]).to include("は全角で入力して下さい")
    end

    # family_name_kana
    it 'family_name_kanaがない場合は登録できないこと' do
      user = build(:user, family_name_kana: nil)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("を入力してください")
    end

    it 'family_name_kanaが36文字以上の場合は登録できないこと' do
      user = build(:user, family_name_kana: 'a'*36)
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は35文字以内で入力してください")
    end

    it 'family_name_kanaが半角の場合は登録できないこと' do
      user = build(:user, family_name_kana: 'ﾃｽﾄ')
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it 'first_name_kanaがカタカナ以外の場合は登録できないこと' do
      user = build(:user, family_name_kana: 'てすと')
      user.valid?
      expect(user.errors[:family_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    # first_name_kana
    it 'first_name_kanaがない場合は登録できないこと' do
      user = build(:user, first_name_kana: nil)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください")
    end

    it 'first_name_kanaが36文字以上の場合は登録できないこと' do
      user = build(:user, first_name_kana: 'a'*36)
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は35文字以内で入力してください")
    end

    it 'first_name_kanaが半角の場合は登録できないこと' do
      user = build(:user, first_name_kana: 'ﾃｽﾄ')
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it 'first_name_kanaがカタカナ以外の場合は登録できないこと' do
      user = build(:user, first_name_kana: 'てすと')
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    # birthday
    it 'birthdayがない場合は登録できないこと' do
      user = build(:user, birthday: nil)
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end
  end
end