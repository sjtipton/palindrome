class AddRatingToLessonPlan < ActiveRecord::Migration
  def change
    add_column :lesson_plans, :rating, :integer
  end
end
