FactoryGirl.define do
  factory :lesson do
    sequence(:short_id) { |n| "lesson-#{n}" }
    course
  end
end