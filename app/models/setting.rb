class Setting < ActiveRecord::Base
  attr_accessible :camera, :camera_link, :admin_password, :hashtag, :maintanance, :status, :twitter_app_id, :twitter_app_oauth, :twitter_app_oauth_token, :twitter_app_token, :twitter_user
end
