# discourse in docker

According to [deploy guideline](https://github.com/discourse/discourse_docker), discourse is cloned to /var/docker

The simplest deployment runs everything in a single container called "app"

+ it maps /var/docker/shared to /shared in the container
+ to ssh into "app", run `/var/docker/launcher ssh app`

or manually run ssh (port is 2222 by default)

+ `ssh root@0.0.0.0 -p 2222`

+ become the `discourse` user to be abble to connect to db by `psql discourse`

+ run rails by `cd /var/www/discourse && RAILS_ENV=production bundle exec rails c`


gi = GithubUserInfo.where("screen_name ilike ?","ming_zhe").first
gi.user

in the container, all the services are described in /etc/service

so... what do i do?

# dump db

As root:

```
ssh root@0.0.0.0 -p 2222 <<HERE
cd /shared
sudo -u discourse pg_dump discourse > discourse-dump.sql
HERE
```

# associate users

it's more work than i want to deal with to fuss around with discourse. let me just consider the specific tasks I need to accomplish.

1. is everybody registered on the forum?
2. what is the github, email, discourse username triplet?
  probably not totally crazy to try to dump it with a rails script in discourse...
3. when posting to discourse automatically, use the discourse username

+ admin can copy student list into a cohort
  + email, github, name
  + copy csv

+ admin can associate fork2 users with discourse users by copying list of discourse users into fork2 admin app
  + copy json
  + error if cannot find a cohort member to associate with

GithubUserInfo.includes(:user)

# Plugin

application.rb calls this:

```
def Discourse.activate_plugins!
  @plugins = Plugin::Instance.find_all("#{Rails.root}/plugins")
  @plugins.each { |plugin| plugin.activate! }
end
```

`plugin#activate!` instance_eval the plugin.rb source in the context of a Plugin::Instance. See available methods in `lib/plugin/instance.rb`

## How to get a plugin to run in docker env

See https://meta.discourse.org/t/installing-plugins-on-docker-install/13364/8


# setting github API for dev

Override

```
SiteSetting
  github_client_secret
  github_client_id

SiteSetting.where(name: "github_client_id").update_all(value: "22f3151c76ccc6efe386")
SiteSetting.where(name: "github_client_secret").update_all(value: "e4d8d665806f7f34f206cbcedcb078247046472f")
```

Also, need to make sure that redirect_uri matches. So run rails on port 4000 inside and outside the vm.

# creating a new topic

Discouse apparently creates a new topic by posting to `/post`

```
raw:and we are going to say something quite random
reply_to_post_number:
category:5
archetype:regular
title:hello world this is a new topic
auto_close_time:
```

If a post is not replying to a topic, it creates a new topic:

```
def new_topic?
  @opts[:topic_id].blank?
end
```