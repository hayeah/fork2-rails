class CoursesController < ApplicationController
  def show
    @course = Course.find_by_short_id(params[:id])
  end
end