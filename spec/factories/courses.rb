FactoryGirl.define do
  factory :course do
    sequence(:short_id) { |n| "course-#{n}" }
    git_url { "http://github.com/test/#{short_id}" }

    factory :course_with_lessons do
      ignore do
        lessons_count 2
      end

      after(:create) do |course, e|
        create_list(:lesson, e.lessons_count, course: course)
      end
    end
  end
end