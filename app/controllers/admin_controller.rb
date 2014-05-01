class AdminController < ApplicationController
  include Auth
  # before_action :verify_admin!
  layout "admin"
end