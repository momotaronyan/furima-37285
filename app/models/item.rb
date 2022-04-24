class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :category
  belongs_to :status
  belongs_to :burden
  belongs_to :prefecture
  belongs_to :scheduled_delivery
  has_many_attached :images
  has_one :order

  validates :images, length: { minimum: 1, maximum: 5, message: "は1枚以上5枚以下にしてください" }
  validates :name, presence: true
  validates :information, presence: true
  validates :price, presence: true
  validates :price, numericality: { only_integer: true, message: 'では半角数字のみを使用してください' }
  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'の価格範囲は 300円 から 9,999,999円 で設定してください' }

  validates :category_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :status_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :burden_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :scheduled_delivery_id, numericality: { other_than: 1 , message: "を選択してください"} 
end