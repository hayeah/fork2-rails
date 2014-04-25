# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  github_id   :string(255)      not null
#  github_data :json
#  name        :string(255)
#  email       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  is_admin    :boolean
#

class User < ActiveRecord::Base
  include Future
  include User::Github

  has_many :cohorts, :through => :cohort_users
  has_many :cohort_users

  def github_data=(data)
    self["github_data"] = data
    self.email ||= data["email"]
    self.name ||= data["name"]
    data
  end

  def generate_auth_token
    self.auth_token = SecureRandom.hex
  end

  def reset_auth_token!
    self.generate_auth_token
    self.save!
  end
end
