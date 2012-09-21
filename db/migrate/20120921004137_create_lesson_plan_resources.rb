class CreateLessonPlanResources < ActiveRecord::Migration
  def change
    create_table :lesson_plan_resources do |t|
      t.integer :lesson_plan_id
      t.string :resource_id

      t.timestamps
    end
  end
end
