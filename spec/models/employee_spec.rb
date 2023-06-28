require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'associations' do
    it { should belong_to(:department) }
    it { should belong_to(:designation) }
    it { should have_many(:bills) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
  end
end