FactoryGirl.define do
  factory :course do
    sequence(:short_id) { |n| "course-#{n}" }
    git_url { "http://github.com/test/#{short_id}" }
  end
end