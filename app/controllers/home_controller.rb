class HomeController < ApplicationController
  before_filter :authenticate_instructor!

  def splash
    @lesson_plan = LessonPlan.new
    @lesson_plans = LessonPlan.where(instructor_id: session[:instructor].id)
  end

end