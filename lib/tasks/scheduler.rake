desc "Let me load some tweets to print!"
task :load_tweets => :environment do
  puts "Loading tweets ..."
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
  puts "done."
end