require "csv"
class Admin::CohortsController < AdminController
  # protect_from_forgery :except => [:create]

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

  def show
    cohort
  end

  # json: email, email, github_id
  def update_users
    records = JSON.parse(params[:cohort][:cohort_users_json])

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

    render "ok"
  end

  def link_discourse_users
    records = JSON.parse(params[:cohort][:discourse_users_json])
    # json: email, github_id, username
    errors = []
    records.each do |record|
      user = User.find_by(email: record["email"].downcase) || User.find_by(github_id: record["github_id"].downcase)
      next if user.nil?
      user.discourse_username = record["username"]
      user.save
    end
    # show cohort users not linked

    render json: {
      "no discourse" => cohort.users.where(discourse_username: nil)
    }
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