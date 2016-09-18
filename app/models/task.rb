class Task < ApplicationRecord
  has_many :users_tasks, dependent: :destroy
  has_many :users, through: :users_tasks

  validates :text, presence: true, length: { maximum: 150 }

  def creator
    users_tasks.find_by_user_type(:creator).user
  end

  def share(user_id)
    users_tasks.create(user: User.find(user_id), user_type: :allowed)
  end
end
