FactoryBot.define do
  factory :order_shipping do
    post_code { '123-4567' }
    prefecture_id { 2 }
    municipality { '川崎市川崎区' }
    address { '4-6-44' }
    building { 'スーパー' }
    phone_number { '07053740819' }
    token { 12345 }
  end
end
