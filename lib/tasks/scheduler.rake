desc "Let me load some tweets to print!"
task :load_tweets => :environment do
  puts "Loading tweets ..."
  Job.load_tweets
  puts "done."
end