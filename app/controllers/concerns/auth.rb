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

  def admin?
    # me && me.admin?
  end

  alias_method :me, :current_user
end