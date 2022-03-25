FactoryBot.define do
  factory :item do
    name                  {Faker::Lorem.sentence}
    information           {Faker::Lorem.sentence}
    price                 {400}
    category_id           {2}
    status_id             {2}
    burden_id             {2}
    prefecture_id         {2}
    scheduled_delivery_id {2}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
