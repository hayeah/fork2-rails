class CoursesController < ApplicationController
  def show
    @course = Course.find_by_param(params[:id])
  end
end