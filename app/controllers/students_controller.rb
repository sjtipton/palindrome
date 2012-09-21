class StudentsController < ApplicationController
    before_filter :authenticate_student!

  def show
    @student = session[:student]
    @lesson_plan = @student.enrolled_course_lesson_plan
  end

end