module ShortLink
  extend ActiveSupport::Concern

  included do
    def self.find_by_param(id)
      if String === id
        self.find_by!(:short_id => id)
      else
        self.find(id)
      end
    end
  end

  def to_param
    short_id
  end
end