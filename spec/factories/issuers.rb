FactoryBot.define do
  factory :issuer do
    name { Faker::Company.name }
    cnpj { Faker::Company.brazilian_company_number(formatted: true) }
    invoice
  end
end
