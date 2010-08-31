class AdminDashboardController < ApplicationController
  before_filter :cataloger_required
  def index;end
end
