class CohortLessonsController < ApplicationController
  before_action :verify_user!, :except => [:checksofa]
  include ActionView::Helpers::AssetTagHelper

  def checksofa
    if params[:format] == "jpg"
      redirect_to sofa_url
    else
      sofa_url
    end
  end

  private

  def sofa_url
    @sofa_url ||= if lesson.sofa_empty?
      image_url("empty-sofa-500px.jpg")
    else
      image_url("sit-on-sofa.jpg")
    end
  end

  def lesson
    @lesson ||= cohort.cohort_lessons.find_by_param params[:id]
  end

  def cohort
    Cohort.find_by_param params[:cohort_id]
  end

end