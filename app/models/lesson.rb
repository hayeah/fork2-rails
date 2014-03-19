# == Schema Information
#
# Table name: lessons
#
#  id         :integer          not null, primary key
#  course_id  :integer          not null
#  short_id   :string(255)      not null
#  commit     :string(40)
#  position   :integer
#  title      :string(255)
#  intro      :text
#  content    :text
#  deleted    :boolean          default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#

class Lesson < ActiveRecord::Base
  include ShortLink

  belongs_to :course
end
