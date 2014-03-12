class Admin::UsersController < AdminController
  def index
    @users = User.all
  end

  def batch_add
    ids = params["github_ids"].split
    ids.each do |id|
      user = User.where(:github_id => id).first
      next if user
      user = User.new(:github_id => id)
      user.update_github_data
      user.save
    end
    redirect_to :action => :index
  end
end