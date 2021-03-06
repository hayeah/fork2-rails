# == Schema Information
#
# Table name: checkins
#
#  id             :integer          not null, primary key
#  cohort_user_id :integer          not null
#  cohort_lesson_id      :integer          not null
#  time_spent     :float
#  difficulty     :integer
#  feedback       :text
#  created_at     :datetime
#  updated_at     :datetime
#  discourse_post_id :integer
#

class Checkin < ActiveRecord::Base
  belongs_to :cohort_user
  belongs_to :cohort_lesson
  has_one :user, :through => :cohort_user

  validates_presence_of :cohort_lesson, :cohort_user, :time_spent, :difficulty, :feedback

  validates :time_spent, :numericality => {
    :greater_than => 0,
    :less_than => 24
  }

  validates :difficulty, :numericality => {
    :greater_than => 0,
    :less_than => 6
  }

  validates_uniqueness_of :cohort_lesson_id, :scope => :cohort_user_id, :message => "already checked in"

  after_save :publish_if_possible
  after_create :maybe_become_sofa

  def discourse_poster
    Checkin::DiscoursePoster.new(self)
  end

  # check if sofa is available
  def maybe_become_sofa
    become_sofa if self.cohort_lesson.sofa_empty?
  end

  def become_sofa
    self.cohort_lesson.set_sofa self
  end

  def publish_if_possible
    # if already posted will update the post
    if can_publish?
      discourse_poster.publish
    end
  end

  # If user has discourse account associated then publish
  def can_publish?
    !user.discourse_username.empty?
  end

  def self.published
    where("discourse_post_id is not null")
  end

  def self.unpublished
    where("discourse_post_id is null")
  end

  def published?
    !self.discourse_post_id.nil?
  end

  def raw_post
    discourse_poster.raw_post
  end
end

class Checkin::DiscoursePoster < Struct.new(:checkin)
  def api
    @api ||= DiscourseAPI.new
  end

  def publish

    topic_id = lesson.discourse_topic_id
    user_name = user.discourse_username

    if checkin.published?
      api.update_post(checkin.discourse_post_id,user_name,raw_post)
    else
      post = api.create_post(topic_id,user_name,raw_post)
      checkin.discourse_post_id = post["id"]
      checkin.save
    end

  end

  def lesson
    checkin.cohort_lesson
  end

  def user
    checkin.user
  end

  DIFFICULTY = %w(太简单 容易 适中 难 太难)

  def repo_url
    github_id = user.github_id
    repo = lesson.repo
    "https://github.com/#{github_id}/#{repo}"
  end

  def diffculty_text
    DIFFICULTY[checkin.difficulty - 1]
  end

  # Compose raw checkin post for discourse
  def raw_post
    repo = repo_url
    post = <<-HERE
+ Repo: [#{repo}](#{repo})
+ 耗时: #{checkin.time_spent}h
+ 难度: #{diffculty_text}

课程遇到的问题和解决方法:

#{checkin.feedback}
HERE
  end
end