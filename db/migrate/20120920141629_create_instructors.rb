class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.integer :institution_id
      t.integer :course_id

      t.timestamps
    end
  end
end
