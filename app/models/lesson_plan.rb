class LessonPlan < ActiveRecord::Base
  attr_accessible :description, :instructor_id, :subject, :title, :topic

  belongs_to :instructor
  has_many :lesson_plan_resources
end
