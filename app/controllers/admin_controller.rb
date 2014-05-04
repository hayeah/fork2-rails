class AdminController < ApplicationController
  include Auth
  include Auth::Grant
  # before_action :verify_admin!
  layout "admin"

  def index
  end

  def check_auth
    raise "Please set api.admin_token in config/config.yaml" if admin_token.nil?
    render json: api_token == admin_token
  end

  def pretend_login
    gid = params[:github_id].downcase

    if user = User.find_by(:github_id => gid)
      auth_user(user)
      redirect_after_auth
    else
      render :text => "Cannot login. User not registered: #{gid}"
    end
  end

  private

  def admin_token
    CONFIG["api"] && CONFIG["api"]["admin_token"]
  end
end