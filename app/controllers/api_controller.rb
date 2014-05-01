class ApiController < ApplicationController
  protect_from_forgery :except => [:auth,:report_test]
  # before_action :verify_user!

  before_action :verify_api_user!, :except => :auth

  # show the user f2 auth token
  def auth
    if request.get?
      show_auth
    elsif request.post?
      check_auth
    end
  end

  # Receive result of test run
  def report_test
    report_data = params.require(:api).permit(:code,:stdout,:project,:suite,:section)
    report = api_user.test_reports.create(report_data)
    if report.valid?
      render text: "ok"
    else
      raise "Invalid report"
    end
  end

  rescue_from StandardError do |e|
    render text: "Uncaught Error: #{e}", status: 500
  end

  private

  def show_auth
    if user = me
      render "auth"
    else
      redirect_to_auth
    end
  end

  def check_auth
    if user = api_user
      render :json => user
    else
      render text: "Invalid access token", status: 403
    end
  end
end