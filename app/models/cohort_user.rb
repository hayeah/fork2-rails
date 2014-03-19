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
  validates :user, :uniqueness => {
    :scope => :cohort
  }
end
