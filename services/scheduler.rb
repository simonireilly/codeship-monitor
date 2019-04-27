require "rufus-scheduler"
require "./clients/codeship"

module Scheduler
  def self.every(interval, job: Codeship)
    scheduler = Rufus::Scheduler.new

    scheduler.every interval do
      job.call
    end

    scheduler.join
  end
end
