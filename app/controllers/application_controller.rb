class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def full_url(url)
    # if not already there, add http://
    # unless the url is blank
    if url.blank?
      return
    else
      url = "http://" + url unless url =~ /\Ahttps?:\/\/.*/
    end
    url
  end

  helper_method :full_url
end
