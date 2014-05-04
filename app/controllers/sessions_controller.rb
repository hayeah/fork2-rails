class SessionsController < ApplicationController
  # show login page
  def login
  end

  def logout
    session.clear
    redirect_to "/"
  end

  include Auth::Grant
  def create
    # http://developer.github.com/v3/users/#response
    github_id = github_user["login"].downcase

    if user = User.find_by(:github_id => github_id)
      auth_user(user)
      redirect_after_auth
    else
      redirect :action => :not_registered
    end
  end

  def not_registered
  end

  private

  def github_user
    auth_hash["extra"]["raw_info"]
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end