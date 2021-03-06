class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  before_filter :set_locale
  after_filter  :discard_flash_if_xhr

  def missing
      flash[:warning] = t('general.invalidURL') + request.original_url
      redirect_to root_path
  end

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

  private
  def extract_locale_from_accept_language_header
    hal = request.env['HTTP_ACCEPT_LANGUAGE']
    if hal
      retval = hal.scan(/^[a-z]{2}/).first
      if "-en-de-".split(retval).count == 2
        retval
      else
        I18n.default_locale
      end
    else
      I18n.default_locale
    end
  end

  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header
    Rails.application.routes.default_url_options[:locale]= I18n.locale 
  end

  protected
  def discard_flash_if_xhr
    flash.discard if request.xhr?
  end

end
