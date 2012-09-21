class LessonResourcesController < ApplicationController
  before_filter :authenticate_instructor!

  def create
  	@lesson_plan = LessonPlan.find(params[:lesson_plan_id])
  	resource_id = params[:lesson_plan_resource][:resource_id]

  	respond_to do |format|
	  	if @lesson_plan.lesson_plan_resources.create(resource_id: resource_id)
        flash.now[:notice] = "Successfully saved Resource to your Lesson Plan"
        format.js
	  	end
    end
  end
end