require 'rails_helper'

describe TasksController do
  let(:user) { FactoryGirl.create(:user) }
  let(:allowed_user) { FactoryGirl.create(:user) }
  let(:task_params) { FactoryGirl.attributes_for(:task, text: Faker::Hipster.sentence) }
  let(:task) { Task.create(task_params) }
  let(:users_task) { FactoryGirl.create(:users_task, user_email: user.email, task_id: task.id) }


  before{ sign_in user }

  describe '#create' do
    context 'success' do
      before { @proc = -> { post :create, format: :js, params: { task: task_params } } }

      it { expect{ @proc.call }.to change(Task, :count).by(1) }
      it { expect{ @proc.call }.to change(UsersTask, :count).by(1) }
      it { expect(@proc.call).to render_template(:create) }
    end

    context 'fail' do
      before { @proc = -> { post :create, format: :js, params: { task: task_params.merge(text: '') } } }

      it { expect{ @proc.call }.not_to change(Task, :count) }
      it { expect{ @proc.call }.not_to change(UsersTask, :count) }
      it { expect(@proc.call).to render_template(:create) }
    end
  end

  describe '#update' do
    before { users_task }
    context 'success' do
      before { @proc = -> { patch :update, format: :js, params: { id: task.id, task: task_params.merge(text: 'Text for tests.') } } }

      it { @proc.call; expect(task.reload.text).to eq 'Text for tests.' }
      it { expect(@proc.call).to render_template(:update)}
    end

    context 'fail' do
      before do
        @text = task.text
        @proc = -> { patch :update, format: :js, params: { id: task.id, task: task_params.merge(text: '') } }
      end

      it { @proc.call; expect(task.reload.text).to eq @text }
      it { expect(@proc.call).to render_template(:update)}
    end
  end

  describe '#destroy' do
    before { users_task }

    context 'success' do
      before { @proc = -> { delete :destroy, format: :js, params: { id: task.id } } }

      it { expect{ @proc.call }.to change(Task, :count).by(-1) }
      it { expect{ @proc.call }.to change(UsersTask, :count).by(-1) }
      it { expect(@proc.call).to render_template(:destroy) }
    end
  end

  describe '#share' do
    before do
      users_task
      allowed_user
    end

    context 'success' do
      before { @proc = -> { post :share, format: :js, params: { id: task.id, users: allowed_user.id.to_s } } }

      it { expect{ @proc.call }.to change(UsersTask, :count).by(1) }
      it { expect(@proc.call).to render_template(:share) }
      end

    context 'fail' do
      before { @proc = -> { post :share, format: :js, params: { id: task.id, users: '' } } }

      it { expect{ @proc.call }.not_to change(UsersTask, :count) }
      it { expect(@proc.call).to render_template(:share) }
    end
  end

  describe '#render_modal' do
    before { @proc = -> { get :render_modal, format: :js, params: { target: 'new' } } }

    it { expect(@proc.call).to render_template('tasks/render_modal') }
  end
end