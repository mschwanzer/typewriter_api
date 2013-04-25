class PagesController < ApplicationController
  def hello
    @jobs = Job.tweet.order("id DESC").limit(10)
    @settings = Setting.last
  end
end
