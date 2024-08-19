FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    ncm { Faker::Number.number(digits: 8).to_s }
    cfop { Faker::Number.number(digits: 4).to_s }
    unit { "kg" }
    quantity { Faker::Number.between(from: 1, to: 100) }
    unit_price { Faker::Commerce.price(range: 10.0..100.0) }
    invoice
  end
end
