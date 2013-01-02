class Tweet < ActiveRecord::Base
  attr_accessible :tweet_id, :tweet_text, :tweeted_at

  def self.scheduled_check
    begin
      latest_tweets = Twitter.user_timeline("delhianimeclub")
      latest_tweets.each do |tweet|
        tweet_present_in_db = false
        Tweet.all.each do |db_tweet|
          tweet_present_in_db = true if db_tweet.tweet_id == tweet.attrs[:id_str].to_s
        end
        if !tweet_present_in_db
          tweet_text = ("RT @delhianimeclub " + tweet.attrs[:text]).slice(0..139)
          Twitter.update(tweet_text)
          Tweet.create(:tweet_id=>tweet.attrs[:id_str], :tweet_text=>tweet.attrs[:text], :tweeted_at => tweet.attrs[:created_at])
        else
        end
      end
    rescue => e
      puts "Exception"
      puts e.message
    end
  end
end
