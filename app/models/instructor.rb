class Instructor < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :course_id, :institution_id

  belongs_to :institution
  belongs_to :course
end
