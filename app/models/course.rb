class Course < ActiveRecord::Base
  validates :short_id, :presence => true
  validates :git_url, :presence => true

  class Repo < Struct.new(:course)
    LOCAL_ROOT = Rails.root + "courses"

    def path
      LOCAL_ROOT + course.short_id
    end

    def exists?
      File.exists?(self.path)
    end

    def update
      if exists?
        pull
      else
        clone
      end
    end

    def pull
      system "cd #{path} && git pull"
    end

    def clone
      system "git clone #{course.git_url} #{path}"
    end
  end

  def repo
    Repo.new(self)
  end
end
