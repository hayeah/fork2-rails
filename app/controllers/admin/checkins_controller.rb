class Admin::CheckinsController < AdminController
  def unpublished
    @checkins = Checkin.unpublished
    render "index"
  end

  def publish_all
    checkins = Checkin.unpublished
    checkins.each(&:publish_if_possible)
    render text: "ok"
  end
end