class AddCohortLessonRepo < ActiveRecord::Migration
  def change
    add_column(:cohort_lessons,:repo,:string)
  end
end
