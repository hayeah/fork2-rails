class CohortUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :cohort
  validates :user, :uniqueness => {
    :scope => :cohort
  }
end