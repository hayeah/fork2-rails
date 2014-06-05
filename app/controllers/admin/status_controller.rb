class Admin::StatusController < ApplicationController

  def index
    @users=CohortUser.all
    @total=13
  end

end
