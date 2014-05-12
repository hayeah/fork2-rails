class AddCohortLessonDiscourseTopic < ActiveRecord::Migration
  def change
    change_table(:cohort_lessons) do |t|
      t.integer :discourse_post_id
      t.integer :discourse_topic_id
    end
  end
end
