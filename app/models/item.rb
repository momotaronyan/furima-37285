class Item < ApplicationRecord

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :burden
  belongs_to :prefecture
  belongs_to :scheduled_delivery

  validates :name, presence: true
  validates :information, presence: true
  validates :price, presence: true

  validates :category_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :status_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :burden_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :prefecture_id, numericality: { other_than: 1 , message: "を選択してください"}
  validates :scheduled_delivery_id, numericality: { other_than: 1 , message: "を選択してください"} 
end