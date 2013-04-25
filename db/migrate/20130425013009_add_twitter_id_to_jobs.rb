class AddTwitterIdToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :tweet_id, :string , :null => true
    add_column :jobs, :profile_image_url, :string
    add_column :jobs, :location, :string
    add_column :jobs, :user_name, :string
    add_column :jobs, :user_id, :string
  end
end