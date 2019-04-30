require 'active_record'

class Build < ActiveRecord::Base
  validates :uuid, uniqueness: true

  class << self
    def safe_update(build)
      self.where(uuid: build["uuid"]).first_or_initialize.tap do |current|
        current.update(build.except("links")) unless current.persisted?
        current.update(finished_at: build["finished_at"]) if current.finished_at.nil?
      end
    end
  end
end
