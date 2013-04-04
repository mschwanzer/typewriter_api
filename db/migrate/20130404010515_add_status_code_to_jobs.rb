class AddStatusCodeToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :status_code, :string , :null => true
  end
end
