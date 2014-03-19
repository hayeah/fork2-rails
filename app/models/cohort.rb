# == Schema Information
#
# Table name: cohorts
#
#  id          :integer          not null, primary key
#  course_id   :integer          not null
#  short_id    :string(255)      not null
#  total_days  :integer          not null
#  current_day :integer          default(0)
#  schedule    :json
#  created_at  :datetime
#  updated_at  :datetime
#

class Cohort < ActiveRecord::Base
  include ShortLink

  belongs_to :course

  has_many :users, :through => :cohort_users
  has_many :lessons, :through => :course
  has_many :cohort_users

  validates :course_id, :presence => true

  validates :short_id, :presence => true, :uniqueness => { :scope => :course_id }

  validates :total_days, :numericality => true, :presence => true

  validates_with ScheduleValidator

  # @param [String] github_id Cohort user Github ID
  # @return [CohortUser]
  # @raise [ActiveRecord::RecordNotFound] if no user exists for a github_id
  def add_users_by_github_id(github_id)
    user = User.find_by!(:github_id => github_id)
    cu = self.cohort_users.find_or_create_by(:user => user)
  end

  # @return [[String]] days as string sorted numerically
  def scheduled_days
    schedule.keys.sort_by(&:to_i)
  end

  # @return [{String => Lesson}] scheduled lessons (insertion order is #scheduled_days)
  def scheduled_lessons
    return @scheduled_lessons if defined?(@scheduled_lessons)
    result = {}
    days = scheduled_days
    days.each do |day|
      lesson_id = schedule[day]
      lesson = self.lessons.find { |lesson| lesson.short_id == lesson_id }
      result[day] = lesson
    end
    @scheduled_lessons = result
  end

  # @return [{Integer => Lesson}] map of user id to next next unfinished lesson
  def progress
    return @progress if defined?(@progress)
    result = {}
    cohort_users.map {|cohort_user|
      result[cohort_user.user_id] = cohort_user.next_unfinished_lesson
    }
    @progress = result
  end
end
