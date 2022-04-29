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


    validates :category_id, presence: true
    validates :status_id, presence: true
    validates :burden_id, presence: true
    validates :prefecture_id, presence: true
    validates :scheduled_delivery_id, presence: true
end