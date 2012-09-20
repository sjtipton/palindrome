class AddFirstNameLastNameToInstructor < ActiveRecord::Migration
  def change
    add_column :instructors, :first_name, :string
    add_column :instructors, :last_name, :string
  end
end
