class CohortLesson < ActiveRecord::Base
  include Permalink
  belongs_to :cohort
end