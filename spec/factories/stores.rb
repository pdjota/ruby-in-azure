FactoryBot.define do
  factory :store do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
    contact_info { Faker::PhoneNumber.phone_number }
  end
end
