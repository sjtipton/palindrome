class LessonPlansController < ApplicationController
  before_filter :authenticate_instructor!

  def index
    @lesson_plans = LessonPlan.where(instructor_id: session[:instructor].id)
  end

  def new
    @lesson_plan = LessonPlan.new
  end

  def create
    @lesson_plan = LessonPlan.new(params[:lesson_plan])

    if @lesson_plan.save
      flash[:notice] = "Successfully created Lesson Plan"
      redirect_to lesson_plan_path(@lesson_plan.id)
    else
      render action "new"
    end
  end

  def show
    @lesson_plan = LessonPlan.find(params[:lesson_plan_id])
    #TODO: Fix the first somehow by finding by resource_id
    @lesson_plan_resource = LessonPlanResource.where(lesson_plan_id: @lesson_plan.id).first

    tags = @lesson_plan.topic.gsub(", ", ",")
    Jefferson::LearningResource.api_query(any_tags: tags) { |lrs| @learning_resources = lrs }
    Jefferson::LearningResource.find(@lesson_plan_resource.resource_id) { |lr| @learning_resource = lr }
    #TODO: Jefferson::LearningResource.find_by_resource_id
    Jefferson::Config.hydra.run
  end

  def edit
    @lesson_plan = LessonPlan.find(params[:lesson_plan_id])
  end

  def update
    @lesson_plan = LessonPlan.find(params[:lesson_plan_id])

    if @lesson_plan.update_attributes(params[:lesson_plan])
      flash[:notice] = "Successfully updated Lesson Plan"
      redirect_to lesson_plan_path(@lesson_plan.id)
    else
      render action: "edit"
    end
  end

  def destroy
    @lesson_plan = LessonPlan.find(params[:lesson_plan_id])
    @lesson_plan.destroy

    flash[:alert] = "Successfully destroyed Lesson Plan"
    redirect_to lesson_plans_path
  end

end