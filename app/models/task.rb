class Task < ApplicationRecord
  validates :text, presence: true, length: { maximum: 150 }
  has_many :users_tasks, dependent: :destroy
  has_many :users, through: :users_tasks

  def creator
    user_tasks.where(user_type: 0).first.user
  end
end
