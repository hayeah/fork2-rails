class LessonsController < ApplicationController

  def show
    lesson
  end

  protected

  def course
    @course ||= Course.find_by_param(params[:course_id])
  end

  def lesson
    @lesson ||= course.lessons.find_by_param(params[:id])
  end

end