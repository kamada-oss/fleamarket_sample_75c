require 'rails_helper'
describe Item do
  describe '#create' do
    it "name, text, item_image, category_id, condition, fee_burden, prefecture, handling_time, priceが入力されている場合出品できる" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "商品名がない場合は登録できないこと" do
      item = build(:item,  name: nil)
      item.valid?
      expect(item.errors[:name]).to include("を入力してください")
    end

    it "商品の説明が空白では保存できない" do
      item = build(:item, text: nil)
      item.valid?
      expect(item.errors[:text]).to include("を入力してください")
    end

    it "商品画像がない場合では保存できない" do
      item_image = build(:item_image, item_image: nil)
      item_image.valid?
      expect(item_image.errors[:item_image]).to include("を入力してください")
    end

    it "カテゴリーがない場合は登録できないこと" do
      item = build(:item, category_id: "")
      item.valid?
      expect(item.errors[:category_id]).to include("を入力してください")
    end

    it "ブランド名がなくても登録できること" do
      item = build(:item, brand_id: "")
      item.valid?
      expect(true).to_not be_nil
    end

    it "商品の状態がない場合は登録できないこと" do
      item = build(:item, condition: "")
      item.valid?
      expect(item.errors[:condition]).to include("を入力してください")
    end

    it "配送料の負担がない場合は登録できないこと" do
      item = build(:item, fee_burden: "")
      item.valid?
      expect(item.errors[:fee_burden]).to include("を入力してください")
    end

    it "発送元の地域がない場合は登録できないこと" do
      item = build(:item, prefecture: "")
      item.valid?
      expect(item.errors[:prefecture]).to include("を入力してください")
    end

    it "発送までの日数がない場合は登録できないこと" do
      item = build(:item, handling_time: "")
      item.valid?
      expect(item.errors[:handling_time]).to include("を入力してください")
    end

    it "販売価格がない場合は登録できないこと" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("を入力してください")
    end

    it "商品名が41字以上は保存できない" do
      string = "あ" * 41
      item = build(:item, name: string)
      item.valid?
      expect(item.errors[:name][0]).to include("は40文字以内で入力してください")
    end

    it "商品の説明が1001字以上は保存できない" do
      string = "あ" * 1001
      item = build(:item, text: string)
      item.valid?
      expect(item.errors[:text][0]).to include("は1000文字以内で入力してください")
    end

    it "販売価格が9_999_999以上は保存できない" do
      int = 10 * 1000 * 1000
      item = build(:item, price: int)
      item.valid?
      expect(item.errors[:price][0]).to include("は9999999以下の値にしてください")
    end
  end
end