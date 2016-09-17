require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.create(:user) }
  let(:allowed_user) { FactoryGirl.create(:user) }

  context 'validations' do
    it { expect(user).to validate_presence_of(:email) }
  end

  context 'relations' do
    it { should have_many(:tasks).dependent(:destroy) }
    it { should have_many(:users_tasks) }
  end
end