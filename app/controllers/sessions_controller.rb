class SessionsController < ApplicationController
  def create
    # http://developer.github.com/v3/users/#response
    github_id = github_user["login"]
    user = User.find_or_create_by(:github_id => github_id) do |user|
      user.github_data = github_user
    end
    auth_user(user)
    redirect_to root_path
  end

  private

  def github_user
    auth_hash["extra"]["raw_info"]
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end