require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'associations' do
    it { should have_many(:employees) }
  end
  subject { FactoryBot.build(:department) }
  context 'Create Departements' do
    describe 'validations' do
      it { should validate_uniqueness_of(:name).case_insensitive }
      it { should validate_presence_of(:name) }
    end
  end
end
