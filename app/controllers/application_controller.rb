# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  def cataloger_required 
    logged_in? && current_user.in_authentication_group?(CATALOGER_ROLES) ? true : redirect_to(root_url)
  end
  
  def require_role(role)
      logged_in? && current_user.send("is_#{role.to_s}?") ? true : redirect_to(root_url)
  end
  
  def require_group(group)
      logged_in? && group.include?(current_user.role.downcase) ? true : redirect_to(root_url)
  end
  
end
