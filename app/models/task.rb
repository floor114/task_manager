class Task < ApplicationRecord
  validates :text, presence: true, length: { maximum: 150 }
  has_many :users_tasks, dependent: :destroy
  has_many :users, through: :users_tasks

  def creator
    users_tasks.where(user_type: 0).first.user
  end

  def share(user_email)
    users_tasks.create(user_email: user_email, user_type: 1)
  end
end
