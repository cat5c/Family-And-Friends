class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user
  	@current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
  	redirect_to '/login' unless current_user
  end

  def location
	  if params[:location].blank?
	    if Rails.env.test? || Rails.env.development?
	      @location ||= Geocoder.search("173.255.190.38").first
	    else
	      @location ||= request.location
	    end
	  else
	    params[:location].each {|l| l = l.to_i } if params[:location].is_a? Array
	    @location ||= Geocoder.search(params[:location]).first
	    @location
	  end
	end

end
