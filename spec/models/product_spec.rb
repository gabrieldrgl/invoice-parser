require "rails_helper"

RSpec.describe Product, type: :model do
  subject { FactoryBot.build(:product) }

  describe "Associations" do
    it { should belong_to(:invoice) }
    it { should have_many(:taxes).dependent(:destroy) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:ncm) }
    it { should validate_presence_of(:cfop) }
    it { should validate_presence_of(:unit) }
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
  end
end
