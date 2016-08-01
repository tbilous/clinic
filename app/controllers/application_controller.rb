class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
 
  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end
  # def default_url_options
  #   { locale: I18n.locale }.merge options
  # end
  def set_locale
    # logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    # if extract_locale_from_accept_language_header == "uk"
    #   I18n.locale = extract_locale_from_accept_language_header
    # else
    #   I18n.locale = "en"
    # end
    I18n.locale = (extract_locale_from_accept_language_header == "uk" ? "uk" : "en" )
    # logger.debug "* Locale set to '#{I18n.locale}'"
  end
  # def after_sign_in_path_for(resource)
  #   # current_user_path
  #   scope = Devise::Mapping.find_scope!(resource)
  #   scope_path = :"#{scope}_root_path"
  #   respond_to?(scope_path, true) ? send(scope_path) : root_path
  # end
  
  def after_sign_in_path_for(resource)
    root_path
  end
 
  def after_sign_out_path_for(resource_or_scope)
    root_path
    # request.referrer
    # scope_path = root_path
    # respond_to?(scope_path, true) ? send(scope_path) : root_path
  end

  private
    def extract_locale_from_accept_language_header
      # request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
      request.env['HTTP_ACCEPT_LANGUAGE'].to_s.scan(/^[a-z]{2}/).first
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
