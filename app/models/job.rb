class Job < ActiveRecord::Base
  attr_accessible :content, :owner, :status_code

  before_save :default_values
  
  def default_values
    self.status_code ||= 'Lined Up'
  end
end