class AddCohortLessonSofa < ActiveRecord::Migration
  def change
    change_table(:cohort_lessons) do |t|
      t.integer :sofa_checkin_id
    end
  end
end
