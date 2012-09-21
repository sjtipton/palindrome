class ApplicationController < ActionController::Base
  protect_from_forgery

  def authenticate_instructor!
  	session[:instructor] ||= Instructor.all.sample
  end

  def authenticate_student!
    session[:student] = Student.find(params[:student_id])
  end

end
