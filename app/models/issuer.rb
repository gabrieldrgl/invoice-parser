class Issuer < ApplicationRecord
  belongs_to :invoice

  validates :name, :cnpj, presence: true
end
