require 'rails_helper'
RSpec.describe OrderShipping, type: :model do
  describe '配送先情報の保存' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @order_shipping = FactoryBot.build(:order_shipping, user_id: user.id, item_id: item.id)
    end

    context '情報が保存される場合' do
      it 'すべての値が正しく入力され、選択できていれば保存できること' do
        expect(@order_shipping).to be_valid
      end
      it 'buildingは空でも保存できること' do
        @order_shipping.building = ''
        expect(@order_shipping).to be_valid
      end
      it 'phone_numberは数字10桁でも保存できること' do
        @order_shipping.phone_number = '0123456789'
        expect(@order_shipping).to be_valid
      end
    end

    context '情報が保存されない場合' do
      it 'post_codeが空だと保存できないこと' do
        @order_shipping.post_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Post code can't be blank")
      end
      it 'prefecture_idが空だと保存できないこと' do
        @order_shipping.prefecture_id = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture を選択してください")
      end
      it 'prefecture_idが1番だと保存できないこと' do
        @order_shipping.prefecture_id = '1'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture を選択してください")
      end
      it 'municipalityが空だと保存できないこと' do
        @order_shipping.municipality = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'addressが空だと保存できないこと' do
        @order_shipping.address = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空だと保存できないこと' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'post_codeが異形式(3桁ハイフン4桁外)だと保存できないこと' do
        @order_shipping.post_code = '01234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Post code は○○○-○○○○の形で入力してください")
      end
      it 'phone_numberが異形式(10桁以上11桁以内の半角数値外)だと保存できないこと' do
        @order_shipping.phone_number = '012345678'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number はハイフン(-)を取った形で入力してください")
      end
      it 'ordersテーブルにおいてuserが紐づいていないと保存できないこと' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'ordersテーブルにおいてitemが紐づいていないと保存できないこと' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
