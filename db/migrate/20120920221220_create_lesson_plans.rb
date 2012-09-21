class CreateLessonPlans < ActiveRecord::Migration
  def change
    create_table :lesson_plans do |t|
      t.string :title
      t.string :subject
      t.string :topic
      t.integer :instructor_id
      t.text :description

      t.timestamps
    end
  end
end
