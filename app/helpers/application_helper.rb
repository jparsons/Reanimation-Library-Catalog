# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def link_to_if_user_is_admin(condition, name, options = {}, html_options = {}, &block)

    if @current_user && @current_user.is_administrator? 
      link_to(condition, name, options, html_options, &block)
    else
      ''
    end
    
  end
end
