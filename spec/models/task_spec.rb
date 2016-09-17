require 'rails_helper'

describe Task do
  let(:user) { FactoryGirl.create(:user) }
  let(:allowed_user) { FactoryGirl.create(:user) }
  let(:task) { FactoryGirl.create(:task) }
  let(:users_task) { FactoryGirl.create(:users_task, user_email: user.email, task_id: task.id) }
  let(:users_task_allowed) { FactoryGirl.create(:users_task_allowed, user_email: allowed_user.email, task_id: task.id) }


  context 'validations' do
    it { expect(task).to validate_presence_of(:text) }
    it { expect(task).to validate_length_of(:text).is_at_most(150) }
  end

  context 'relations' do
    it { should have_many(:users) }
    it { should have_many(:users_tasks).dependent(:destroy) }
  end

  context 'methods' do
    describe '.creator' do
      before { users_task }

      it { expect(task.creator).to eq user }
    end

    describe '.share' do
      before do
        users_task
        users_task_allowed
      end
      it { expect(task.users).to include allowed_user }
      it { expect(task.users).to include user }
      it { expect(task.users_tasks.last.user).to eq allowed_user }
      it { expect(task.users_tasks.last.user_type).to eq 'allowed' }
    end
  end
end