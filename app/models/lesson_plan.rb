class LessonPlan < ActiveRecord::Base
  attr_accessible :description, :instructor_id, :subject, :title, :topic

  belongs_to :instructor
  has_many :lesson_plan_resources


  def similar_lesson_plans
    tags = self.topic.split(', ')
    lesson_plans = []
    tags.each do |t|
      lesson_plans << LessonPlan.where("topic like ? AND id <> ?", "%#{t}%", self.id)
    end
    lesson_plans
  end
end
