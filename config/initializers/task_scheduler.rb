require 'rubygems'
require 'rufus/scheduler'
scheduler = Rufus::Scheduler.start_new
# => The scheduler calls this method evey minute, you can set it to whatever interval you like
scheduler.every("1m") do
  Tweet.scheduled_check
end
