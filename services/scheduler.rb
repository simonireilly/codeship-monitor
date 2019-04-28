require "rufus-scheduler"

require "./services/persister"
require "./clients/codeship"

module Scheduler
  def self.every(interval, job: Codeship)
    scheduler = Rufus::Scheduler.new

    puts "Recurring job begginning for every #{interval}"

    scheduler.every interval do
      data = job.call

      data.each do |build|
        Build.where(uuid: build["uuid"]).first_or_initialize.tap do |current|
          current.update(build.except("links")) unless current.persisted?
          current.update(finished_at: build["finished_at"]) if current.finished_at.nil?
        end
      end
    end

    scheduler.join
  end
end
