FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    barcode { Faker::Barcode.ean(13) }
  end
end
