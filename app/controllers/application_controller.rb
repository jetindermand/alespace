class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def after_sign_in_path_for(resource)
 	return user_path(resource)
  end

  private

  def track_activity(trackable, action = params[:action])
    current_user.activities.create! action: action, trackable: trackable
  end
end
