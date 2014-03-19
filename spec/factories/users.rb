FactoryGirl.define do
  factory :user do
    sequence(:github_id) { |n| "user_#{n}" }
  end
end