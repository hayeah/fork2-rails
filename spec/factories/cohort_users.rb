FactoryGirl.define do
  factory :cohort_user do
    association :cohort
    association :user
  end
end