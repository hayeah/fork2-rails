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
#  auth_token  :string(255)      default(""), not null
#

class User < ActiveRecord::Base
  include Future
  include User::Github

  has_many :cohorts, :through => :cohort_users
  has_many :cohort_users

  has_many :test_reports

  before_save do |me|
    me.email = me.email.downcase
    me.github_id = me.github_id.downcase
  end

  def self.with_no_discourse
    self.where(discourse_username: nil)
  end

  def link_discourse_user!
    self.discourse_username = find_discourse_username
    self.save!
  end

  def find_discourse_username
    api = DiscourseAPI.new
    result = api.user(github_id: self.github_id,email: self.email)
    result["discourse_username"]
  end

  def leave_cohort(cohort)
    cohort_users.where(cohort_id: cohort).destroy_all
  end

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
