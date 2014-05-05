class DiscourseAPI
  HOST = CONFIG["discourse"]["host"]
  TOKEN = CONFIG["discourse"]["secret"]

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
end