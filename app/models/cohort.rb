class Cohort < ActiveRecord::Base
  include ShortLink

  belongs_to :course

  has_many :users, :through => :cohort_users
  has_many :lessons, :through => :course
  has_many :cohort_users

  validates :course_id, :presence => true

  validates :short_id, :presence => true, :uniqueness => { :scope => :course_id }

  validates :total_days, :numericality => true, :presence => true

  # @param [String] github_id Cohort user Github ID
  # @return [CohortUser]
  # @raise [ActiveRecord::RecordNotFound] if no user exists for a github_id
  def add_users_by_github_id(github_id)
    user = User.find_by!(:github_id => github_id)
    cu = self.cohort_users.find_or_create_by(:user => user)
  end
end