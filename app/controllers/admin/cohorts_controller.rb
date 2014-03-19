class Admin::CohortsController < AdminController
  def index
    @cohorts = Cohort.all
  end

  def create
    course = Course.find_by_param(params[:course_id])
    @cohort = Cohort.create(create_params.merge(:course => course))
    if @cohort.valid?
      redirect_to :action => :index
    else
      render "new"
    end
  end

  def edit
    cohort
  end

  def new
    @cohort
  end

  def add_users
    fails = []
    github_ids.each do |github_id|
      begin
        cohort.add_users_by_github_id github_id
      rescue ActiveRecord::RecordNotFound
        fails << github_id
      end
    end

    if !fails.empty?
      ids = fails.join ", "
      msg = "The following Github users don't exist: #{ids}"
      cohort.errors.add(:cohort_users,msg)
      render "edit"
    else
      redirect_to :action => :edit
    end
  end

  private

  def cohort
    @cohort ||= Cohort.find_by_param(params[:id])
  end

  def create_params
    params.require(:cohort).permit(:total_days,:short_id)
  end

  module FormHelper
    # From form value
    # @return [[String]]
    def github_ids
      params[:github_ids].split.uniq
    end

    # To form value
    # @param [[String]] ids Cohort users' Github IDs
    def form_github_ids(ids)
      ids.join("\n")
    end
  end
  helper FormHelper
  include FormHelper
end