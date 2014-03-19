class CohortsController < ApplicationController
  before_action :verify_user!

  def show
    cohort
  end

  def checkin
    cohort; lesson_to_checkin
    if request.post?
      @checkin = cohort_user.checkin(lesson_to_checkin,checkin_params)
      if @checkin.valid?
        redirect_to cohort
      end
    else
      @checkin = Checkin.new
    end
  end

  protected

  def checkin_params
    params.require(:checkin).permit(:time_spent,:feedback,:difficulty)
  end

  def lesson_to_checkin
    @lesson ||= cohort.lessons.find_by_param(params[:lesson_id])
  end

  def cohort
    @cohort ||= me.cohorts.find_by_param(params[:id])
  end

  def cohort_user
    cohort.cohort_users.find_by(:user => me)
  end
end