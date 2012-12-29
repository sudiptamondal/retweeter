class Tweet < ActiveRecord::Base
  attr_accessible :tweet_id, :tweet_text, :tweeted_at

  def self.scheduled_check
    latest_tweets = Twitter.user_timeline("delhianimeclub")
 
    latest_tweets.each do |tweet|
      puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
      puts "current_tweet_id:       ::::   " + tweet.attrs[:id].to_s
      puts "current_tweet_created_at::::   " + tweet.attrs[:created_at].to_s
      puts "current_tweet_text      ::::   " + tweet.attrs[:text].to_s
      puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
      
      tweet_present_in_db = false

      Tweet.all.each do |db_tweet|
        if db_tweet.tweet_id == tweet.attrs[:id].to_s
          tweet_present_in_db = true
        end
      end
      
      if !tweet_present_in_db
        puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        puts "Adding a new tweet"
        Tweet.create(:tweet_id=>tweet.attrs[:id_str], :tweet_text=>tweet.attrs[:text], :tweeted_at => tweet.attrs[:created_at])
        puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        tweet_text = "RT @delhianimeclub " + tweet.attrs[:text]
        Twitter.update(tweet_text)
      else
        puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
        puts "Tweet already present"
        puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
      end
    end
  end
end
