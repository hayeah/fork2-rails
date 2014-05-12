class DiscourseAPI
  HOST = CONFIG["discourse"]["host"]
  TOKEN = CONFIG["discourse"]["secret"]

  MYAPI = "#{HOST}/myapi"

  def create_topic(username,title,raw,category_id=nil)
    # raw:and we are going to say something quite random
    # reply_to_post_number:
    # category:5
    # archetype:regular
    # title:hello world this is a new topic
    url = "#{HOST}/posts"
    r = RestClient.post url, {
      raw: raw,
      title: title,
      archetype: "regular",
      category_id: category_id
    }, {
      :accept => :json,
      :params => {
        :api_username => username,
        :api_key => TOKEN
      }
    }
    JSON.parse(r.body)
  end

  def update_topic(post_id,username,title,raw,category_id=nil)
    # raw:and we are going to say something quite random
    # reply_to_post_number:
    # category:5
    # archetype:regular
    # title:hello world this is a new topic
    url = "#{HOST}/posts/#{post_id}"
    r = RestClient.put url, {
      post: {
        raw: raw,
        archetype: "regular",
        category_id: category_id
      },
      title: title
    }, {
      :accept => :json,
      :params => {
        :api_username => username,
        :api_key => TOKEN
      }
    }
    JSON.parse(r.body)
  end

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