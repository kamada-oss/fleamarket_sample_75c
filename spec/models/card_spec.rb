require 'rails_helper'
describe Card do
  describe '#create' do
    it 'card_idがない場合は登録できないこと' do
      card = build(:card, card_id: nil)
      card.valid?
      expect(card.errors[:card_id]).to include("を入力してください")
    end

    it 'customer_idがない場合は登録できないこと' do
      card = build(:card, customer_id: nil)
      card.valid?
      expect(card.errors[:customer_id]).to include("を入力してください")
    end
  end
end