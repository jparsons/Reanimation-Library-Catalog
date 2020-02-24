class ApplicationController < ActionController::Base

  def cataloger_required
    user_signed_in? && current_user.in_authentication_group?(CATALOGER_ROLES) ? true : redirect_to(new_user_session_path)
  end

  def require_role(role)
      user_signed_in? && current_user.send("is_#{role.to_s}?") ? true : redirect_to(root_url)
  end

  def require_group(group)
      user_signed_in? && group.include?(current_user.role.downcase) ? true : redirect_to(root_url)
  end

  def authorized_user
    user_signed_in? && current_user.in_authentication_group?(CATALOGER_ROLES)
  end
end
