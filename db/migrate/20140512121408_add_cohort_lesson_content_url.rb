class AddCohortLessonContentUrl < ActiveRecord::Migration
  def change
    change_table(:cohort_lessons) do |t|
      t.string :content_url
    end
  end
end
