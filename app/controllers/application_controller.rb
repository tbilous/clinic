class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale
 
  # def set_locale
  #   I18n.locale = params[:locale] || I18n.default_locale
  # end
  # def default_url_options
  #   { locale: I18n.locale }.merge options
  # end
  def set_locale
    # logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    if extract_locale_from_accept_language_header == "uk"
      I18n.locale = extract_locale_from_accept_language_header
    else
      I18n.locale = "en"
    end
    # logger.debug "* Locale set to '#{I18n.locale}'"
  end
 
  private
    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
end
