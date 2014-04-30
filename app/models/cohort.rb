# == Schema Information
#
# Table name: cohorts
#
#  id        :integer          not null, primary key
#  permalink :string(255)      not null
#

class Cohort < ActiveRecord::Base
  include Permalink

  def cohort_users_csv
  end

  has_many :users, :through => :cohort_users
  has_many :cohort_users
end
