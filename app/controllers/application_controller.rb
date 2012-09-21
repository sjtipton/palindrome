class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_instructor!
  	session[:instructor] ||= Instructor.all.sample
  end
end
