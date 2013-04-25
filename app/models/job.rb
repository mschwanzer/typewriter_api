class Job < ActiveRecord::Base
  attr_accessible :content, :owner, :status_code, :tweet_id, :location, :profile_image_url, :user_id, :user_name

  before_save :default_values
  
  def default_values
    self.status_code ||= 'Lined Up'
  end

  scope :tweet, :conditions => ['tweet_id IS NOT NULL']

  def self.load_tweets
    if Job.tweet.count > 0 
      @id = Job.tweet.last.tweet_id
    else
      @id = 100000000
    end
    Twitter.mentions(:since_id=>@id).each do |r|
      puts "#{r.id}:#{r.from_user}: #{r.text}"
      #puts r.inspect
      if r.text.include? "#printme"
        Job.create(:tweet_id => r.id, :owner => r.from_user, :content => r.text, :location => r.user.location, :profile_image_url => r.user.profile_image_url, :user_id =>r.user.id, :user_name => r.user.name) 
      end
    end
  end
end