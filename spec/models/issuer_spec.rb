require "rails_helper"

RSpec.describe Issuer, type: :model do
  subject { FactoryBot.build(:issuer) }

  describe "Associations" do
    it { should belong_to(:invoice) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cnpj) }
  end
end
