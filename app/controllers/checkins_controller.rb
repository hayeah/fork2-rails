class CheckinsController < ApplicationController
  before_action :verify_user!

  def new
    cohort; lesson
    @checkin = Checkin.new
    render "edit"
  end

  def edit
    cohort; lesson; checkin
  end

  def update
    checkin.update_attributes(checkin_params)
    redirect_to :action => :edit
  end

  def create
    cohort; lesson
    @checkin = cohort_user.checkin(lesson,checkin_params)
    if @checkin.valid?
      redirect_to cohort
    else
      render "edit"
    end
  end

  private

  def checkin
    @checkin ||= cohort_user.find_checkin_by_lesson(lesson)
  end

  def cohort
    @cohort ||= me.cohorts.find_by_param(params[:cohort_id])
  end

  def cohort_user
    @cohort_user ||= cohort.cohort_users.find_by(:user => me)
  end

  def lesson
    @lesson ||= cohort.lessons.find_by_param(params[:lesson_id])
  end

  def checkin_params
    params.require(:checkin).permit(:time_spent,:feedback,:difficulty)
  end

end