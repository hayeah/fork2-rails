=begin
Copy to /var/docker/shared/dump-discourse-users.rb on discourse machine

ssh root@0.0.0.0 -p 2222 <<HERE
sudo -u discourse sh -c "cd /var/www/discourse && RAILS_ENV=production bundle exec rails runner /shared/dump-discourse-users.rb > /shared/dusers.json"
HERE
=end

data = GithubUserInfo.includes(:user).map do |github|
  user = github.user

  {
    id: user.id,
    username: user.username,
    email: user.email,
    github_id: github.screen_name,
  }
end

puts data.to_json