class User < ActiveRecord::Base
  include Future
  include User::Github
end
