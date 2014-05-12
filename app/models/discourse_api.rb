class DiscourseAPI
  HOST = CONFIG["discourse"]["host"]
  TOKEN = CONFIG["discourse"]["secret"]

  MYAPI = "#{HOST}/myapi"

  def create_post(topic_id,user_id,raw)
    thread_url = "#{HOST}/posts"
    r = RestClient.post thread_url, {
      :topic_id => topic_id,
      :raw => raw,
    }, {
      :accept => :json,
      :params => {
        :api_username => user_id,
        :api_key => TOKEN
      }
    }
    JSON.parse(r.body)
  end

  def user(query)
    url = "#{MYAPI}/user"
    query = query.slice(:email,:github_id)
    r = RestClient.get url, :params => query.merge(api_key: TOKEN)
    JSON.parse(r.body)
  end
end