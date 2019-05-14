require "dotenv/load"
require "./app/services/scheduler.rb"
Scheduler.every("600s")
