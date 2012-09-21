class LessonResourcesController < ApplicationController
  before_filter :authenticate_instructor!

  def create
  	@lesson_plan = LessonPlan.find(params[:lesson_plan_id])
    @lesson_plan_resources = @lesson_plan.lesson_plan_resources
    @similar_lesson_plans = @lesson_plan.similar_lesson_plans

    tags = @lesson_plan.topic.gsub(", ", ",")
    Jefferson::LearningResource.api_query(any_tags: tags) { |lrs| @learning_resources = lrs }
    Jefferson::Config.hydra.run
  	resource_id = params[:lesson_plan_resource][:resource_id]

  	respond_to do |format|
	  	if @lesson_plan.lesson_plan_resources.create(resource_id: resource_id)
        @learning_resources = @learning_resources.delete_if { |lr| lr.id.in? @lesson_plan_resources.map(&:resource_id) }
        flash.now[:notice] = "Successfully saved Resource to your Lesson Plan"
        format.js
	  	end
    end
  end
end