class ChangeLessonDiscourseUrlToId < ActiveRecord::Migration
  def up
    remove_column(:cohort_lessons,:discourse_thread_url)
    add_column(:cohort_lessons,:discourse_thread_id,:integer)
  end
end
