FactoryBot.define do
  factory :user do
    nickname              {Faker::Name.initials(number: 2)}
    email                 {Faker::Internet.free_email}
    password              {Faker::Internet.password(min_length: 6)}
    password_confirmation {password}
    family_name           
    first_name            
    family_name_kana      
    first_name_kana       
    birthday              { Faker::Date.backward }
  end
end
first_name_kana { person.first.katakana }
   last_name_kana { person.last.katakana }