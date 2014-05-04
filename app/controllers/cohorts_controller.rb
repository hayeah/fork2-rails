class CohortsController < ApplicationController
  before_action :verify_user!

  def show
    cohort; cohort_user
  end

  def checkin
    cohort; lesson
    raise "lesson doesn't exist: #{lesson.permalink}" if lesson.nil?

    if lesson_checkin.nil?
      @checkin = Checkin.new
    end
  end

  def do_checkin
    @checkin = Checkin.find_or_initialize_by(lesson_checkin_finder)
    @checkin.attributes = lesson_checkin_update_attributes
    @checkin.save
    if @checkin.valid?
      flash[:success] = "Checkin Success"
      redirect_to :action => :checkin
    else
      flash[:error] = "Checkin Error"
      render "checkin"
    end
  end

  protected

  def lesson_checkin_update_attributes
    params.require(:checkin).permit(:time_spent,:difficulty,:feedback)
  end

  def lesson_checkin_finder
    {:cohort_lesson_id => lesson.id,:cohort_user_id => cohort_user.id}
  end

  def lesson_checkin
    @checkin ||= Checkin.find_by(lesson_checkin_finder)
  end

  def lesson
    @lesson ||= cohort.active_lessons.find_by_param(params[:cohort_lesson_id])
  end

  def cohort
    @cohort ||= me.cohorts.find_by_param(params[:id])
  end

  def cohort_user
    @cohort_user ||= cohort.cohort_users.find_by(:user => me)
  end
end