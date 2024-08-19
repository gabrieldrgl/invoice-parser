FactoryBot.define do
  factory :tax do
    icms_value { Faker::Commerce.price(range: 1.0..10.0) }
    ipi_value { Faker::Commerce.price(range: 1.0..10.0) }
    pis_value { Faker::Commerce.price(range: 1.0..10.0) }
    cofins_value { Faker::Commerce.price(range: 1.0..10.0) }
    product
  end
end
