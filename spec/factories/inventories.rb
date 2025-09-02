FactoryBot.define do
  factory :inventory do
    association :product
    association :store
    available_quantity { Faker::Number.between(from: 0, to: 100) }
  end
end
