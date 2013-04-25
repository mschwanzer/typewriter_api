class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.text :status
      t.boolean :maintanance
      t.boolean :camera
      t.string :camera_link
      t.string :admin_password
      t.string :hashtag
      t.string :twitter_user
      t.string :twitter_app_id
      t.string :twitter_app_token
      t.string :twitter_app_oauth
      t.string :twitter_app_oauth_token

      t.timestamps
    end
  end
end
