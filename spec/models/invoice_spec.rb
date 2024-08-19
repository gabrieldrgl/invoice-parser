# spec/models/invoice_spec.rb

require "rails_helper"

RSpec.describe Invoice, type: :model do
  subject { FactoryBot.build(:invoice) }

  describe "Associations" do
    it { should have_one(:issuer).dependent(:destroy) }
    it { should have_one(:recipient).dependent(:destroy) }
    it { should have_many(:products).dependent(:destroy) }
  end

  describe "Validations" do
    it { should validate_presence_of(:series) }
    it { should validate_presence_of(:number) }
    it { should validate_presence_of(:emission_date) }
  end
end
