# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  def admin_required
    unless logged_in? && @current_user.is_administrator?
      if logged_in?
        flash[:notice] = "You do not have clearance to view this page"
        redirect_to root_url
      else
        flash[:notice] = "You have to log in before you can see that page."
        redirect_to login_url
      end
    end
  end
  
  def cataloger_required
    unless logged_in? && (@current_user.is_administrator? || @current_user.is_cataloger?)
      if logged_in?
        flash[:notice] = "You do not have clearance to view this page"
        redirect_to root_url
      else
        flash[:notice] = "You have to log in before you can see that page."
        redirect_to login_url
      end
    end
  end
end
