class Invoice < ApplicationRecord
  has_one :issuer, dependent: :destroy
  has_one :recipient, dependent: :destroy
  has_many :products, dependent: :destroy

  validates :series, :number, :emission_date, presence: true
end
