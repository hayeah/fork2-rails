class CohortLesson < ActiveRecord::Base
  include Permalink
  belongs_to :cohort
  has_many :checkins

  def sofa_empty?
    sofa_checkin_id.nil?
  end

  def sofa_checkin
    @sofa_checkin ||= self.sofa_checkin_id && Checkin.find(self.sofa_checkin_id)
  end

  def set_sofa(checkin)
    self.sofa_checkin_id = checkin.id
    save
  end

  def previous_lesson
    return @previous_lesson if defined?(@previous_lesson)
    @previous_lesson = self.cohort.cohort_lessons.where(position: self.position - 1).first
  end

  def number
    position + 1
  end

  def publisher
    DiscoursePublisher.new(self)
  end

  def publish
    publisher.publish
  end

  def published?
    self.discourse_topic_id.present?
  end

  class DiscoursePublisher < Struct.new(:lesson)
    include Rails.application.routes.url_helpers

    def api
      @api ||= DiscourseAPI.new
    end

    def title
      "Lesson #{lesson.position+1} - #{lesson.title} (#{lesson.cohort.permalink})"
    end

    def placeholder_content
      "empty"
    end

    def coach_username
      "hayeah"
    end

    def checkin_rankings
      return unless lesson.previous_lesson
      checkins = lesson.previous_lesson.checkins.order("id asc")
      return if checkins.count < 1
      first = checkins[0]
      second = checkins[1]
      raw = <<-HERE
上一课的签到排名：

#{"@" + first.user.discourse_username + " 抢了沙发"}
#{"@" + second.user.discourse_username + " 抢了板凳" if second}
HERE
    end

    def markdown_content
      sofa_url = checksofa_cohort_cohort_lesson_url(lesson.cohort,lesson,format: "jpg")
      checkin_url = checkin_cohort_url(lesson.cohort,lesson)

      raw = <<-HERE
#{checkin_rankings}

[课程链接](#{lesson.content_url})
[打卡链接](#{checkin_url})

**提交问题** 课程相关问题请在论坛提问。[如何提问课程问题](http://d.fork2.com/t/topic/160/2)

**打卡制度**：为了能帮助我更好的控制内容长度，完成课程以后请打卡。

请你 [猛击链接](#{checkin_url}) 来打卡。

## 沙发空着吗？

![sofa](#{sofa_url})
HERE
    end

    def category
      lesson.cohort.discourse_category_name
    end

    def create_topic
      r = api.create_topic(coach_username,title,placeholder_content,category)
      lesson.discourse_post_id = r["id"]
      lesson.discourse_topic_id = r["topic_id"]
      lesson.save!
    end

    def maybe_create_topic
      create_topic unless lesson.published?
    end

    def update_topic
      api.update_topic(lesson.discourse_post_id,coach_username,title,markdown_content,category)
    end

    def publish
      # create a place holder post
      maybe_create_topic
      # create the full post
      update_topic
    end
  end
end

