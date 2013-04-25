Twitter.configure do |config|
  if Setting.count > 0
    config.consumer_key = Setting.last.twitter_app_id
    config.consumer_secret = Setting.last.twitter_app_token
    config.oauth_token = Setting.last.twitter_app_oauth
    config.oauth_token_secret = Setting.last.twitter_app_oauth_token
  end
end