require "dotenv/load"
require "./app/services/scheduler.rb"

(300..350\).each do |page|
  data = Codeship.call(page_number: page)

  data.each do |build|
    Build.safe_update(build)
  end

  puts "Data #{page} - Written"
  sleep(60)
end
