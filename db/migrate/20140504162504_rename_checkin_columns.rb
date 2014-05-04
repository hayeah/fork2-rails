class RenameCheckinColumns < ActiveRecord::Migration
  def change
    change_table(:checkins) do |t|
      t.rename(:lesson_id,:cohort_lesson_id)
    end
  end
end
