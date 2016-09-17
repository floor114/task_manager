class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable
  has_many :users_tasks, foreign_key: 'user_email', primary_key: 'email'
  has_many :tasks, through: :users_tasks, dependent: :destroy

  scope :all_except, ->(user) { where.not(id: user) }
end
