# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  
  def cataloger_required 
    logged_in? && current_user.in_authentication_group?(CATALOGER_ROLES) ? true : redirect_to(root_url)
  end
  
  def require_role(role)
      logged_in? && current_user.send("is_#{role.to_s}?") ? true : redirect_to(root_url)
  end
  
  def require_group(group)
      logged_in? && group.include?(current_user.role.downcase) ? true : redirect_to(root_url)
  end

  protected
      def render_json(json, options={})
        callback, variable = params[:callback], params[:variable]
        response = begin
          if callback && variable
            "var #{variable} = #{json};\n#{callback}(#{variable});"
          elsif variable
            "var #{variable} = #{json};"
          elsif callback
            "#{callback}(#{json});"
          else
            json
          end
        end
        render({:content_type => :js, :text => response}.merge(options))
      end  
  
end
