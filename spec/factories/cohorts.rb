FactoryGirl.define do
  factory :cohort do
    sequence(:short_id) { |n| "course-#{n}" }
    total_days 21
    schedule({})
    association :course

    factory :cohort_with_users do
      ignore do
        users_count 2
      end

      after(:create) do |cohort,e|
        create_list(:cohort_user, e.users_count, cohort: cohort)
      end
    end
  end
end