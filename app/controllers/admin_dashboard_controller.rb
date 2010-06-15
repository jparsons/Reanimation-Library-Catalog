class AdminDashboardController < ApplicationController
  before_filter :cataloger_required
  layout "admin"
  def index;end
end
