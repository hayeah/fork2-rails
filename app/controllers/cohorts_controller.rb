class CohortsController < ApplicationController
  before_action :verify_user!

  def show
    cohort; cohort_user
  end

  protected

  def cohort
    @cohort ||= me.cohorts.find_by_param(params[:id])
  end

  def cohort_user
    @cohort_user ||= cohort.cohort_users.find_by(:user => me)
  end
end