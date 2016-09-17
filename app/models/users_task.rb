class UsersTask < ApplicationRecord
  belongs_to :user, foreign_key: 'user_email', primary_key: 'email'
  belongs_to :task

  validates :user_email, uniqueness: { scope: :task_id }
  validates :user_email, :task_id, presence: true

  enum user_type: [:creator, :allowed]
end
