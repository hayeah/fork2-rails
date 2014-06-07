class Admin::StatusController < ApplicationController

  def users
    @users=CohortUser.all
    @total_courses=13
    start_date=Date.new(2014,5,1)
    @start_mjd=start_date.mjd
    @intervals=Date.today.mjd-@start_mjd
  end

end
