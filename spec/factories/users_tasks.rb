FactoryGirl.define do
  factory :users_task do
  end

  factory :users_task_creator, parent: :users_task do
    user_type :creator
  end

  factory :users_task_allowed, parent: :users_task do
    user_type :allowed
  end
end