get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_or_create_by(:screen_name => params[:username])
  @user.fetch_tweets! if @user.tweets_stale?
  @tweets = @user.tweets.limit(10)
  p @tweets.first
  erb :index
end
