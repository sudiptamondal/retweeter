class StaticController < ApplicationController
  def retweets
    @tweets = Tweet.all
  end
  def home
    
  end
end
