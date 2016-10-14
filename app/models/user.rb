class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :confirmable
  has_many :users_tasks
  has_many :tasks, through: :users_tasks, dependent: :destroy

  scope :all_except, ->(user) { where.not(id: user) }

  delegate :can?, :cannot?, to: :ability

  def ability
    @ability ||= Ability.new(self)
  end
end
