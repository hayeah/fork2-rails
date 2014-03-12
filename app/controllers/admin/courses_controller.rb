class Admin::CoursesController < AdminController
  def index
    @courses = Course.all
  end

  def create
    Course.create(course_params)
    redirect_to :action => :index
  end

  private
  def course_params
    params.require(:course).permit(:short_id,:git_url,:duration)
  end
end