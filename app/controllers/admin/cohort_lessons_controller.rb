class Admin::CohortLessonsController < AdminController
  def publish
    lesson.publish
    redirect_to ["admin",cohort]
  end

  private

  def cohort
    @cohort ||= Cohort.find_by_param(params[:cohort_id])
  end

  def lesson
    cohort.cohort_lessons.find_by_param(params[:cohort_lesson_id])
  end
end