class LakesController < ApplicationController
  skip_before_action :logged_in?
  def index
  end
end
