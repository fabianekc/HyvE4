class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :set_locale

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

  private
  def extract_locale_from_accept_language_header
    hal = request.env['HTTP_ACCEPT_LANGUAGE']
    if hal
      hal.scan(/^[a-z]{2}/).first
    else
      I18n.default_locale
    end
  end

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header
    Rails.application.routes.default_url_options[:locale]= I18n.locale 
  end
end
