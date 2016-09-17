FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "#{n.to_words}@user.com" }
    password { Faker::Internet.password }
    after(:build) {|user| user.skip_confirmation! }
  end
end