class RemoveLessonDiscourseThreadId < ActiveRecord::Migration
  def up
    CohortLesson.where("discourse_thread_id is not null").each {|l| l.discourse_topic_id = l.discourse_thread_id; l.save}
    remove_column(:cohort_lessons,:discourse_thread_id)
  end
end
