class Cohort
  class ScheduleValidator < ActiveModel::Validator
    def validate(cohort)
      schedule = cohort.schedule
      return if schedule.nil?



      # check that all lessons exist
      lessons = schedule.values
      for day, lesson in schedule
        cohort.errors.add(:schedule,"#{lesson} not found") unless cohort.lessons.find_by(:short_id => lesson)

        # check for duplicate lessons
        cohort.errors.add(:schedule,"day #{day} - #{lesson}: is a duplicate") if lessons.count(lesson) > 1

        # check that days are numerical
        begin
          Integer(day)
        rescue ArgumentError
          cohort.errors.add(:schedule,"#{day} - #{lesson}: is not a numerical day")
        end
      end
    end
  end
end