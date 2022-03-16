# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| nickname           | string | null: false               |
| family_name        | text   | null: false               |
| first_name         | text   | null: false               |
| family_name_kana   | text   | null: false               |
| first_name_kana    | text   | null: false               |
| birthday           | date   | null: false               |

has_many:products, dependent:destroy
has_many:orders, dependent:destroy

## products テーブル

| Column                | Type       | Options                        |
| ----------------------| ---------- | ------------------------------ |
| name                  | string     | null: false                    |
| information           | text       | null: false                    |
| category_id           | text       | null: false, foreign_key: true |
| status_id             | references | null: false, foreign_key: true |
| burden_id             | references | null: false, foreign_key: true |
| prefecture_id         | references | null: false, foreign_key: true |
| scheduled_delivery_id | references | null: false, foreign_key: true |
| price                 | integer    | null: false                    |
| user_id               | references | null: false, foreign_key: true |

belongs_to :user
has_one_attached :image
has_one :order
belongs_to :category, dependent:destroy
belongs_to :status, dependent:destroy
belongs_to :burden, dependent:destroy
belongs_to :scheduled_delivery, dependent:destroy
belongs_to :prefecture, dependent:destroy


## shippings テーブル

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| post_cord      | text       | null: false                    |
| prefecture_id  | references | null: false, foreign_key: true |
| municipalities | string     | null: false                    |
| address        | string     | null: false                    |
| building       | string     |                                |
| phone_number   | string     | null: false, foreign_key: true |

has_many :orders
belongs_to :prefecture

## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| user_id     | references | null: false, foreign_key: true |
| product_id  | references | null: false, foreign_key: true |
| shipping_id | references | null: false, foreign_key: true |

belongs_to :user
belongs_to :product
belongs_to :shipping

## categories テーブル

| Column   | Type       | Options     |
| -------- | ---------- | ----------- |
| category | text       | null: false |

has_many:products

## statuses テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| statuses | text       | null: false                    |

has_many:products

## burdens テーブル

| Column  | Type       | Options                        |
| ------- | ---------- | ------------------------------ |
| burdens | text       | null: false                    |

has_many:products

## prefectures テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| prefectures | text       | null: false                    |

has_many:products
has_many:shippings

## scheduled_deliveries テーブル

| Column               | Type       | Options                        |
| -------------------- | ---------- | ------------------------------ |
| scheduled_deliveries | text       | null: false                    |

has_many:products