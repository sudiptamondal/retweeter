class StaticController < ApplicationController
  def status
    @data = {}
    #@client = Twitter::Client.new
    
    #@tweets = Twitter.user_timeline("akmur", :count => 5)
    #@a = Twitter.update("Tweeting as the authenticated user!")
    @tweets_from_dac = Twitter.user_timeline("delhianimeclub")
    p @tweets_from_dac
  end
end
