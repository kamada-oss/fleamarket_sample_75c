require 'rails_helper'
describe Comment do
  describe '#create' do
    it "textが空白では保存できないこと" do
      comment = build(:comment, text: nil)
      comment.valid?
      expect(comment.errors[:text]).to include("を入力してください")
    end
  end
end