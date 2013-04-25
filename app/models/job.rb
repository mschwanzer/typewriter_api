class Job < ActiveRecord::Base
  attr_accessible :content, :owner, :status_code, :tweet_id, :location, :profile_image_url, :user_id, :user_name

  before_save :default_values
  
  def default_values
    self.status_code ||= 'Lined Up'
  end

  scope :tweet, :conditions => ['tweet_id IS NOT NULL']
end