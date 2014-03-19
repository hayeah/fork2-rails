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
#

class User < ActiveRecord::Base
  include Future
  include User::Github

  def github_data=(data)
    self["github_data"] = data
    self.email ||= data["email"]
    self.name ||= data["name"]
    data
  end
end
