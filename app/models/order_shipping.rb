class OrderShipping
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :municipality, :address, :building, :phone_number, :order_id, :item_id, :user_id

  with_options presence: true do
    validates :post_code, format: {with: /\A\d{3}[-]\d{4}\z/, message: 'は○○○-○○○○の形で入力してください'}
    validates :municipality
    validates :address
    validates :phone_number, format: {with: /\A\d{10}$|^\d{11}\z/, message: 'はハイフン(-)を取った形で入力してください'}
    validates :prefecture_id
    validates :item_id
    validates :user_id
  end
  validates :prefecture_id, numericality: { other_than: 1 , message: "を選択してください"}

  def save
    # 注文情報を保存し、変数に代入してshippingで扱えるようにする
    order = Order.create(item_id: item_id, user_id: user_id)
    # 注文情報込みの配送先を保存する
    Shipping.create(post_code: post_code, prefecture_id: prefecture_id, municipality: municipality, address: address, building: building, phone_number: phone_number, order_id: order.id)
  end
end