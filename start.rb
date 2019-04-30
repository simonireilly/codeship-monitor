require "dotenv/load"
require "./app/services/scheduler.rb"
Scheduler.every("15s")
