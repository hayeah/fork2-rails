class Course
  # @param [CourseBuilder::Project] project
  class Loader < Struct.new(:course,:project)
    # lesson objects read from repo
    def repo_lessons
      @repo_lessons ||= project.lessons
    end

    # lesson objects saved in db
    def db_lessons
      course.lessons
    end

    def deleted_lesson_keys
      repo_lesson_keys = Set.new(repo_lessons.map(&:short_id))
      db_lesson_keys = Set.new(db_lessons.map(&:short_id))
      (db_lesson_keys - repo_lesson_keys).to_a
    end

    def lessons_to_delete
      db_lessons.where(:short_id => deleted_lesson_keys)
    end

    # + update stale lessons
    # + create new lessons
    # + mark deleted lessons from repo as deleted
    def update_lessons
      flag_deleted_lessons
      update_lessons
    end

    # mark deleted lessons
    def flag_deleted_lessons
      lessons_to_delete.update_all(:deleted => true)
    end

    # update or create lessons
    def update_lessons
      repo_lessons.each do |repo_lesson|
        db_lesson = db_lessons.find_or_initialize_by(:short_id => repo_lesson.short_id)
        db_lesson.deleted = false
        db_lesson.update_attributes \
          :position => repo_lesson.position,
          :title => repo_lesson.title,
          :intro => repo_lesson.intro,
          :content => repo_lesson.content,
          :commit => repo_lesson.commit
        db_lesson.save
      end
    end
  end
end