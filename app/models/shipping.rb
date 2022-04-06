class Shipping < ApplicationRecord
  belongs_to :order
  belongs_to :prefecture

  with_options presence: true do
    validates :post_code, format: {with: /\A\d{3}[-]\d{4}\z/, message: 'test'}
    validates :municipality
    validates :address
    validates :phone_number, numericality: { only_integer: true, message: 'では半角数字のみを使用してください' }
  end
  validates :prefecture_id, numericality: { other_than: 1 , message: "を選択してください"}
end