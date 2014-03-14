class Lesson < ActiveRecord::Base
  include ShortLink

  belongs_to :course
end