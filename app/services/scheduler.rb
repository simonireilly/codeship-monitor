require "rufus-scheduler"

require "./app/services/persister"
require "./app/clients/codeship"
require "./app/models/build"

module Scheduler
  def self.every(interval, job: Codeship)
    scheduler = Rufus::Scheduler.new

    puts "Recurring job begginning for every #{interval}"

    scheduler.every interval do
      data = job.call

      data.each do |build|
        Build.safe_update(build)
      end
    end

    scheduler.join
  end
end
