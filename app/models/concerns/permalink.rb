module Permalink
  extend ActiveSupport::Concern

  included do
    def self.find_by_param(id)
      if String === id
        self.find_by!(:permalink => id)
      else
        self.find(id)
      end
    end
  end

  def to_param
    self.permalink
  end
end