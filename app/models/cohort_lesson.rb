class CohortLesson < ActiveRecord::Base
  include Permalink
  belongs_to :cohort
  has_many :checkins

  def sofa_empty?
    sofa_checkin_id.nil?
  end

  def sofa_checkin
    @sofa_checkin ||= self.sofa_checkin_id && Checkin.find(self.sofa_checkin_id)
  end

  def set_sofa(checkin)
    self.sofa_checkin_id = checkin.id
    save
  end
end

