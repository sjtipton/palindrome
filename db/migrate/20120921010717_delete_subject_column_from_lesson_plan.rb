class DeleteSubjectColumnFromLessonPlan < ActiveRecord::Migration
  def up
    remove_column :lesson_plans, :subject
  end

  def down
    add_column :lesson_plans, :subject, :string
  end
end
