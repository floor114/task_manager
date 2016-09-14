class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable

  has_many :users_tasks, foreign_key: 'user_email', primary_key: 'email'
  has_many :tasks, through: :users_tasks
  scope :all_except, ->(user) { where.not(id: user) }
end