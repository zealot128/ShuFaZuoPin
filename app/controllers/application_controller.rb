class ApplicationController < ActionController::Base
  include ControllerAuthentication
  #protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    #exception.subject -> resource, .action -> :edit ...
    if current_user.present?
      redirect_to root_url, :alert => exception.message
    else
      redirect_to login_path, :alert => exception.message
    end
  end

end
