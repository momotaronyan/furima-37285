require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能のテストコード' do
    it '必須項目の記述及び選択ができていれば出品できる' do
      expect(@item).to be_valid
    end
    it 'imageが空では保存できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it 'nameが空では保存できない' do
      @item.name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it 'informationが空では保存できない' do
      @item.information = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Information can't be blank")
    end
    it 'category_idが1番(未選択)だと出品できない' do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Category を選択してください")
    end
    it 'status_idが1番(未選択)だと出品できない' do
      @item.status_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Status を選択してください")
    end
    it 'burden_idが1番(未選択)だと出品できない' do
      @item.burden_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Burden を選択してください")
    end
    it 'prefecture_idが1番(未選択)だと出品できない' do
      @item.prefecture_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Prefecture を選択してください")
    end
    it 'scheduled_delivery_idが1番(未選択)だと出品できない' do
      @item.scheduled_delivery_id = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Scheduled delivery を選択してください")
    end
    it 'priceが空では保存できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceが¥300~¥9,999,999外の価格で保存できない' do
      @item.price = 1
      @item.valid?
      expect(@item.errors.full_messages).to include("Price の価格範囲は 300円 から 9,999,999円 で設定してください")
    end
    it 'priceの値が半角数字以外では保存できない' do
      @item.price = '千円'
      @item.valid?
      expect(@item.errors.full_messages).to include("Price では半角数字のみを使用してください")
    end
  end
end