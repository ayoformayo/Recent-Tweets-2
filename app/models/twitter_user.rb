class TwitterUser < ActiveRecord::Base
  has_many :tweets


  def fetch_tweets!
    tweets = Twitter.user_timeline(self.screen_name, :count => 10)
    self.tweets = tweets.map { |t| Tweet.create(:text => t.text, 
                                                :twitter_user_id => self.id,
                                                :tweeted_at => t.created_at)}
  end

  def tweets_stale?
    return true if self.tweets.empty?
    avg = (self.tweets.first.tweeted_at - self.tweets.last.tweeted_at)/10
    p "#{avg}^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
    Time.now - self.tweets.first.created_at > avg
  end
end
