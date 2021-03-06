class MainController < ApplicationController
  def root
    if signed_in?
      cohort_index
    else
      landing_page
    end
  end

  protected

  def cohort_index
    if current_cohort.nil?
      render "cohorts/none"
    else
      redirect_to current_cohort
    end
  end

  def landing_page
    render "landing"
  end

  private

  def current_cohort
    @cohort ||= me.cohorts.last
  end

  def course
    @course ||= current_cohort.course
  end
end