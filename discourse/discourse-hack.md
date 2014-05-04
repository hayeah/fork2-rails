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
sudo -u discourse pg_dump discourse > /shared/psql-04-28-2014.sql
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