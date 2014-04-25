module Auth
  module Grant
    private
    def auth_user(user)
      session[:auth_user] = user.id
    end
  end

  private

  def current_user
    session[:auth_user] && User.find(session[:auth_user])
  end

  alias_method :me, :current_user

  def api_user
    return @api_user if defined?(@api_user)
    @api_user = if api_token
      User.find_by(auth_token: api_token)
    end
  end

  def api_token
    request.headers["API-Token"]
  end

  def verify_api_user!
    if api_token.nil?
      render text: "No API token", status: 403
    elsif api_user.nil?
      render text: "Invalid API token", status: 403
    end
  end

  def redirect_to_auth
    redirect_to login_path
  end

  def redirect_after_auth
    redirect_to root_path
  end

  def signed_in?
    !me.nil?
  end

  def admin?
    me && me.is_admin?
  end

  def verify_admin!
    admin? || raise("not admin, yo")
  end

  def verify_user!
    signed_in?
  end

  alias_method :me, :current_user
end