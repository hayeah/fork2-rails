class Course
  class Repo < Struct.new(:course)
    def exists?
      File.exists?(course.path)
    end

    def update
      if exists?
        pull
      else
        clone
      end
    end

    def pull
      system "cd #{course.path} && git pull"
    end

    def clone
      system "git clone #{course.git_url} #{course.path}"
    end
  end

  def repo
    Repo.new(self)
  end
end