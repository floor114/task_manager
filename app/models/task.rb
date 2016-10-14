class Task < ApplicationRecord
  before_update :update_notification
  before_destroy :destroy_notification

  has_many :users_tasks, dependent: :destroy
  has_many :users, through: :users_tasks

  scope :all_except, ->(task) { where.not(id: task) }

  validates :text, presence: true, length: { maximum: 150 }

  def creator
    users_tasks.find_by_user_type(:creator).user
  end

  def share(user_id)
    user = User.find(user_id)
    users_tasks.create(user: user, user_type: :allowed)
    partial = ApplicationController.renderer.render(partial: 'tasks/task_card', locals: { task: self, user: user })
    ActionCable.server.broadcast "notification_channel_#{user_id}", partial: partial, action: 'share'
  end

  def update_notification
    users.each do |user|
      partial = ApplicationController.renderer.render(partial: 'tasks/task', locals: { task: self, user: user })
      ActionCable.server.broadcast "notification_channel_#{user.id}", partial: partial, action: 'update', task_id: self.id
    end
  end

  def destroy_notification
    users.each do |user|
      partial = ApplicationController.renderer.render(partial: 'tasks/tasks_table', locals: { tasks: user.tasks.all_except(self), user: user })
      ActionCable.server.broadcast "notification_channel_#{user.id}", partial: partial, action: 'destroy', task_id: self.id
    end
  end
end
