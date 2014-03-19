class Course < ActiveRecord::Base
  include ShortLink

  validates :short_id, :presence => true
  validates :git_url, :presence => true

  has_many :lessons

  LOCAL_ROOT = Rails.root + "courses"

  def path
    LOCAL_ROOT + self.short_id
  end

  def loader(path=self.path)
    Loader.new(self,project(path))
  end

  def project(path=self.path)
    ::CourseBuilder::Project.new(path)
  end

  def refresh_repo
    repo.update
    loader.update_lessons
  end
end
