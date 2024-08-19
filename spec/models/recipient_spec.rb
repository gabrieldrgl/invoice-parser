require "rails_helper"

RSpec.describe Recipient, type: :model do
  subject { FactoryBot.build(:recipient) }

  describe "Associations" do
    it { should belong_to(:invoice) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cnpj) }
  end
end
