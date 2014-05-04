a topic has many posts. a "comment" is a post to a post in a topic. the frontend post to `/posts` with the following form:

```
raw:hello+world+world+world
topic_id:27
reply_to_post_number:1
category:4
archetype:regular
auto_close_time:
```

# How API auth work:

`/lib/auth/default_current_user_provider.rb`

+ if the query parameters `api_key` exists
  + and if the api_key's user matches the `api_username`
  + then current_user is the user given by api_username (downcased)

super api key is one with no associated user. it would accept any `api_username`

# how to post

category and archetype are related to creating new topics

curl -X POST \
  -F 'topic_id=27' \
  -F raw=helloworldhelloworldhelloworld4 \
  'localhost:3000/posts?api_key=5848619a9cefd8d814cb75a436cc55ee7532bc3bb6abcd716b92c20cec1c89a2&api_username=hayeah'

{"id":87,"name":"Howard","username":"hayeah","avatar_template":"//www.gravatar.com/avatar/f0bef81280041011039a28a49e83c7dd.png?s={size}&r=pg&d=identicon","created_at":"2014-04-26T00:13:31.545-04:00","cooked":"<p>helloworldhelloworldhelloworld4</p>","post_number":13,"post_type":1,"updated_at":"2014-04-26T00:13:31.545-04:00","reply_count":0,"reply_to_post_number":null,"quote_count":0,"avg_time":null,"incoming_link_count":0,"reads":0,"score":0,"yours":true,"topic_slug":"most-important-sci-fi-movie-of-the-2000s","topic_id":27,"display_username":"Howard","primary_group_name":null,"version":1,"can_edit":true,"can_delete":true,"can_recover":true,"user_title":null,"actions_summary":[{"id":2,"count":0,"hidden":false,"can_act":false},{"id":3,"count":0,"hidden":false,"can_act":true,"can_clear_flags":true},{"id":4,"count":0,"hidden":false,"can_act":true,"can_clear_flags":true},{"id":5,"count":0,"hidden":true,"can_act":true,"can_clear_flags":false},{"id":6,"count":0,"hidden":false,"can_act":true,"can_clear_flags":false},{"id":7,"count":0,"hidden":false,"can_act":true,"can_clear_flags":true},{"id":8,"count":0,"hidden":false,"can_act":true,"can_clear_flags":true}],"moderator":false,"staff":true,"user_id":28,"draft_sequence":5,"hidden":false,"hidden_reason_id":null,"trust_level":0,"deleted_at":null,"user_deleted":false,"edit_reason":null,"can_view_edit_history":true}

curl localhost:3000/posts/87.json

# get the specified post by topic id and its rank number


`curl -i http://localhost:3000/posts/by_number/27/12.json`

returns topic 27's 12th post

# see if user exists

username is case insensitive:

curl -i localhost:4000/users/hayeah.json
curl -i localhost:4000/users/HAYEAH.json


curl -I localhost:4000/users/nouser.json => 404