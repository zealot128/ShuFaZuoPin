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

  #rescue_from Exception do |exception|
    #ExceptionMailer.deliver_exception(exception, self).deliver
    #throw exception
  #end

  def default_url_options(options={})
    { :locale => I18n.locale }
  end

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
