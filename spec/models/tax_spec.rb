require "rails_helper"

RSpec.describe Tax, type: :model do
  subject { FactoryBot.build(:tax) }

  describe "Associations" do
    it { should belong_to(:product) }
  end
end
