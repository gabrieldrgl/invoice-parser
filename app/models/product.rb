class Product < ApplicationRecord
  belongs_to :invoice
  has_many :taxes, dependent: :destroy

  validates :name, :ncm, :cfop, :unit, :quantity, :unit_price, presence: true
end
