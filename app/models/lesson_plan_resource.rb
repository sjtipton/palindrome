class LessonPlanResource < ActiveRecord::Base
  attr_accessible :lesson_plan_id, :resource_id

  belongs_to :lesson_plan
end
