class CohortLesson < ActiveRecord::Base
  include Permalink
  belongs_to :cohort
  has_many :checkins
end

