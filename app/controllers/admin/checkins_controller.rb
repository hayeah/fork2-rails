class Admin::CheckinsController < AdminController
  def unpublished
    @checkins = Checkin.unpublished
    render "index"
  end
end