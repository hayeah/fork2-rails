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
end
