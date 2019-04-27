require "dotenv/load"
require "./services/scheduler.rb"
Scheduler.every("15s")
