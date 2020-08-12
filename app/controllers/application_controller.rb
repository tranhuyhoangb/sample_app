class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale

  private

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    if I18n.available_locales.include? locale
      I18n.locale = locale
    else
      I18n.default_locale
    end
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?

    store_location
    flash[:danger] = t ".logged_in"
    redirect_to login_url
  end

  def find_user
    @user = User.find_by id: params[:id]
    return if @user

    redirect_to root_path
  end
end
