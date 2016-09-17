FactoryGirl.define do
  factory :task do
    text Faker::Hipster.sentence
  end
end