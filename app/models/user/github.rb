module User::Github
  extend ActiveSupport::Concern
  def github
    API.new(self)
  end

  def update_github_data
    data = github.public_info
    self.github_data = data
  end

  class API < Struct.new(:user)
    ROOT = URI("https://api.github.com")

    def public_info
      get("/users/#{@user.github_id}")
    end

    def get(resource)
      data = RestClient.get (ROOT + resource).to_s, {:accept => :json}
      JSON.parse(data)
    end
  end
end

