get '/' do
  erb :index
end

get '/:username' do
  @user = TwitterUser.find_or_create_by(:screen_name => params[:username])
  if @user.tweets_stale?
  @user.fetch_tweets!
  end
  @tweets = @user.tweets.limit(10)
  p @tweets.first
  erb :index
end

post '/get_tweets' do
  user = TwitterUser.find(params[:user_id])
  if user.tweets_stale?
    user.fetch_tweets!
  end
end
