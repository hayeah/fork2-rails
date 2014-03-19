# == Schema Information
#
# Table name: checkins
#
#  id             :integer          not null, primary key
#  cohort_user_id :integer          not null
#  lesson_id      :integer          not null
#  time_spent     :float
#  difficulty     :integer
#  feedback       :text
#  created_at     :datetime
#  updated_at     :datetime
#

class Checkin < ActiveRecord::Base
  belongs_to :cohort_user
  belongs_to :lesson

  validates_presence_of :lesson, :cohort_user, :time_spent, :difficulty, :feedback
  validate :time_spent, :numericality => {
    :greater_than => 0,
    :less_than => 24
  }

  validate :difficulty, :numericality => {
    :greater_than => 0,
    :less_than => 6
  }

  validates_uniqueness_of :lesson_id, :scope => :cohort_user_id
end
