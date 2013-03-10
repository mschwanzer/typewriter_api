class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :owner
      t.text :content

      t.timestamps
    end
  end
end
