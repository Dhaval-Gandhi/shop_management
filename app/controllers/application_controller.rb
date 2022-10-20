class ApplicationController < ActionController::Base
  # http_basic_authenticate_with :name => "admin", :password => "v.negandhi"
  before_action :authenticate

  def authenticate
    unless session[:login_status]
      redirect_to login_path
    end
  end
end
