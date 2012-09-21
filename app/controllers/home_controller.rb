class HomeController < ApplicationController
  before_filter :authenticate_instructor!

	def splash
    @lesson_plan = LessonPlan.new
	end

end