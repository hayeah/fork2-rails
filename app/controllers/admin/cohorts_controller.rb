require "csv"
class Admin::CohortsController < AdminController
  protect_from_forgery :except => [:create]

  def index
    @cohorts = Cohort.all
  end

  def create
    @cohort = Cohort.create(create_params)
    if @cohort.valid?
      redirect_to :action => :index
    else
      render "new"
    end
  end

  # def update
  #   cohort.update(update_params)
  #   if cohort.valid?
  #     redirect_to :action => :edit
  #   else
  #     render "edit"
  #   end
  # end

  def edit
    cohort
  end

  def new
    @cohort = Cohort.new
  end

  def update_users
    csv = params[:cohort][:cohort_users_csv]
    reader = CSV.new(csv)

    headers = reader.shift
    rows = reader.read
    records = rows.map { |row| Hash[headers.zip(row)] }

    keys = [:email]
    fields = [:name,:github_id]

    keys = keys.map(&:to_s)
    fields = fields.map(&:to_s)

    records.each do |record|
      finder = record.slice(*keys)
      user = User.find_or_initialize_by(finder)
      user.attributes = record.slice(*fields)
      user.save

      CohortUser.find_or_create_by(:user_id => user.id, :cohort_id => cohort.id)
    end
  end

  private

  def cohort
    @cohort ||= Cohort.find_by_param(params[:id])
  end

  def create_params
    params.require(:cohort).permit(:permalink)
  end

  # def update_params
  #   create_params.merge(:schedule => from_form_schedule)
  # end
end