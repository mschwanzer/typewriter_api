class ApplicationController < ActionController::Base
  protect_from_forgery

  private 

  def authenticate
    if Setting.count > 0
      authenticate_or_request_with_http_basic('Administration') do |username, password|
        username == 'admin' && password == Setting.last.admin_password
      end
    end
  end
end
