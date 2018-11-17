class ApplicationController < ActionController::Base
	include SessionsHelper
	before_action :logged_in?
end
