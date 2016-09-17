require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  let(:user) { FactoryGirl.create(:user) }
  let(:allowed_user) { FactoryGirl.create(:user) }
  let(:task) { FactoryGirl.create(:task) }
  let(:users_task) { FactoryGirl.create(:users_task, user_email: user.email, task_id: task.id) }
  let(:users_task_allowed) { FactoryGirl.create(:users_task_allowed, user_email: allowed_user.email, task_id: task.id) }
  let(:guest_ability) { Ability.new(nil) }
  let(:user_ability) { Ability.new(user) }
  let(:allowed_user_ability) { Ability.new(allowed_user) }

  describe 'User' do
    context 'guest ability' do
      it { expect(guest_ability).not_to be_able_to :index, Task }
    end

    context 'user ability' do
      before { users_task }

      it { expect(user_ability).to be_able_to :create, Task }
      it { expect(user_ability).to be_able_to :edit, task }
      it { expect(user_ability).to be_able_to :update, task }
      it { expect(user_ability).to be_able_to :share, task }
      it { expect(user_ability).to be_able_to :destroy, task }
    end

    context 'allowed user ability' do
      before do
        users_task
        users_task_allowed
      end
      it { expect(allowed_user_ability).to be_able_to :edit, task }
      it { expect(allowed_user_ability).to be_able_to :update, task }
      it { expect(allowed_user_ability).to be_able_to :destroy, task }
      it { expect(allowed_user_ability).not_to be_able_to :share, task }
    end

  end

end