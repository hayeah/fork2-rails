FactoryGirl.define do
  factory :cohort do
    sequence(:short_id) { |n| "course-#{n}" }
    total_days 21
    schedule({})
    association :course
  end
end