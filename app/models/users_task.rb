class UsersTask < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user_id, :task_id, presence: true

  enum user_type: [:creator, :allowed]
end
