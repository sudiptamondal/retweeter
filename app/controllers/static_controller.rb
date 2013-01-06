class StaticController < ApplicationController
  def status
    @tweets = Tweet.all
  end
end
