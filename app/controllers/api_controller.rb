class ApiController < ApplicationController
  protect_from_forgery :except => :auth
  # before_action :verify_user!

  # show the user f2 auth token
  def auth
    if request.get?
      show_auth
    elsif request.post?
      check_auth
    end
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
      render text: "no such user", status: 404
    end
  end
end