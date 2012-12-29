require 'rubygems'
require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new
scheduler.every("1m") do
	puts "Checking for new tweets @" + Time.now.to_s
  Tweet.scheduled_check
end
