require 'rails_helper'
describe DeliverAddress do
  describe '#create' do
    it 'family_name, first_name, family_name_kana, first_name_kana, zip_code, prefecture, city, address1があれば登録できること' do
      deliver_address = build(:deliver_address)
      expect(deliver_address).to be_valid
    end

    # famlily_name
    it 'family_nameがない場合は登録できないこと' do
      deliver_address = build(:deliver_address, family_name: nil)
      deliver_address.valid?
      expect(deliver_address.errors[:family_name]).to include("を入力してください")
    end

    it 'family_nameが36文字以上の場合は登録できないこと' do
      deliver_address = build(:deliver_address, family_name: 'a'*36)
      deliver_address.valid?
      expect(deliver_address.errors[:family_name]).to include("は35文字以内で入力してください")
    end

    it 'family_nameが半角の場合は登録できないこと' do
      deliver_address = build(:deliver_address, family_name: 'ﾃｽﾄ')
      deliver_address.valid?
      expect(deliver_address.errors[:family_name]).to include("は全角で入力して下さい")
    end

    # first_name
    it 'first_nameがない場合は登録できないこと' do
      deliver_address = build(:deliver_address, first_name: nil)
      deliver_address.valid?
      expect(deliver_address.errors[:first_name]).to include("を入力してください")
    end

    it 'first_nameが36文字以上の場合は登録できないこと' do
      deliver_address = build(:deliver_address, first_name: 'a'*36)
      deliver_address.valid?
      expect(deliver_address.errors[:first_name]).to include("は35文字以内で入力してください")
    end

    it 'first_nameが半角の場合は登録できないこと' do
      deliver_address = build(:deliver_address, first_name: 'ﾃｽﾄ')
      deliver_address.valid?
      expect(deliver_address.errors[:first_name]).to include("は全角で入力して下さい")
    end

    # family_name_kana
    it 'family_name_kanaがない場合は登録できないこと' do
      deliver_address = build(:deliver_address, family_name_kana: nil)
      deliver_address.valid?
      expect(deliver_address.errors[:family_name_kana]).to include("を入力してください")
    end

    it 'family_name_kanaが36文字以上の場合は登録できないこと' do
      deliver_address = build(:deliver_address, family_name_kana: 'a'*36)
      deliver_address.valid?
      expect(deliver_address.errors[:family_name_kana]).to include("は35文字以内で入力してください")
    end

    it 'family_name_kanaが半角の場合は登録できないこと' do
      deliver_address = build(:deliver_address, family_name_kana: 'ﾃｽﾄ')
      deliver_address.valid?
      expect(deliver_address.errors[:family_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it 'first_name_kanaがカタカナ以外の場合は登録できないこと' do
      deliver_address = build(:deliver_address, family_name_kana: 'てすと')
      deliver_address.valid?
      expect(deliver_address.errors[:family_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    # first_name_kana
    it 'first_name_kanaがない場合は登録できないこと' do
      deliver_address = build(:deliver_address, first_name_kana: nil)
      deliver_address.valid?
      expect(deliver_address.errors[:first_name_kana]).to include("を入力してください")
    end

    it 'first_name_kanaが36文字以上の場合は登録できないこと' do
      deliver_address = build(:deliver_address, first_name_kana: 'a'*36)
      deliver_address.valid?
      expect(deliver_address.errors[:first_name_kana]).to include("は35文字以内で入力してください")
    end

    it 'first_name_kanaが半角の場合は登録できないこと' do
      deliver_address = build(:deliver_address, first_name_kana: 'ﾃｽﾄ')
      deliver_address.valid?
      expect(deliver_address.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    it 'first_name_kanaがカタカナ以外の場合は登録できないこと' do
      deliver_address = build(:deliver_address, first_name_kana: 'てすと')
      deliver_address.valid?
      expect(deliver_address.errors[:first_name_kana]).to include("は全角カタカナで入力して下さい")
    end

    # zip_code
    it 'zip_codeがない場合は登録できないこと' do
      deliver_address = build(:deliver_address, zip_code: nil)
      deliver_address.valid?
      expect(deliver_address.errors[:zip_code]).to include("を入力してください")
    end

    it 'zip_codeが6文字以下の場合は登録できるないこと' do
      deliver_address = build(:deliver_address, zip_code: 123456)
      deliver_address.valid?
      expect(deliver_address.errors[:zip_code]).to include("は7文字で入力してください")
    end

    it 'zip_codeが8文字以下の場合は登録できるないこと' do
      deliver_address = build(:deliver_address, zip_code: 12345678)
      deliver_address.valid?
      expect(deliver_address.errors[:zip_code]).to include("は7文字で入力してください")
    end
    
    # prefecture
    it 'prefectureがない場合は登録できないこと' do
      deliver_address = build(:deliver_address, prefecture: nil)
      deliver_address.valid?
      expect(deliver_address.errors[:prefecture]).to include("を入力してください")
    end

    # city
    it 'cityがない場合は登録できないこと' do
      deliver_address = build(:deliver_address, city: nil)
      deliver_address.valid?
      expect(deliver_address.errors[:city]).to include("を入力してください")
    end

    it 'cityが36文字以上の場合は登録できないこと' do
      deliver_address = build(:deliver_address, city: 'a'*36)
      deliver_address.valid?
      expect(deliver_address.errors[:city]).to include("は35文字以内で入力してください")
    end

    # address1
    it 'address1がない場合は登録できないこと' do
      deliver_address = build(:deliver_address, address1: nil)
      deliver_address.valid?
      expect(deliver_address.errors[:address1]).to include("を入力してください")
    end
  end
end