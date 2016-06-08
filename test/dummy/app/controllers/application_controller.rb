class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :init_bigbluebutton_variables

  def init_bigbluebutton_variables
    @bbb_endpoint = 'http://test-install.blindsidenetworks.com/bigbluebutton/api'
    @bbb_secret = '8cd8ef52e8e101574e400365b55e11a6'
  end
end
