# == Schema Information
#
# Table name: cohort_users
#
#  id        :integer          not null, primary key
#  cohort_id :integer          not null
#  user_id   :integer          not null
#

class CohortUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :cohort
  has_many :checkins

  validates :user, :uniqueness => {
    :scope => :cohort
  }

  def checkin(lesson,attrs={})
    self.checkins.create(attrs.merge(lesson: lesson))
  end

  def finished?(lesson)
    checkins.find { |checkin| checkin.lesson_id == lesson.id }
  end

  # The next available lesson that's not yet checked in
  # @return [Lesson?] nil if there's no unfinished lessons
  def next_unfinished_lesson
    # checkins
    unfinished_lessons[unfinished_lessons.keys.first]
  end

  # @return [[Lesson]]
  def unfinished_lessons
    @unfinished_lessons ||= cohort.scheduled_lessons.reject { |day,lesson|
      finished?(lesson)
    }
  end
end
