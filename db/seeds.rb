course = Course.create(:short_id => "example-course", :git_url => "https://github.com/hayeah/fork2-example-course.git")
course.refresh_repo