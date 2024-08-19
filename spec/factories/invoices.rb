FactoryBot.define do
  factory :invoice do
    series { "A1" }
    number { Faker::Number.number(digits: 6).to_s }
    emission_date { Faker::Date.backward(days: 14) }
  end
end
