FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    after(:build) {|user| user.skip_confirmation! }
  end
end