class AdminController < ApplicationController
  include Auth
  # before_action :verify_admin!
  layout "admin"

  def check_auth
    raise "Please set api.admin_token in config/config.yaml" if admin_token.nil?
    render json: api_token == admin_token
  end

  private

  def admin_token
    CONFIG["api"] && CONFIG["api"]["admin_token"]
  end
end