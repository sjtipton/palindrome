class Student < ActiveRecord::Base
  attr_accessible :first_name, :institution_id, :last_name

  belongs_to :institution
  has_many :enrollments
end
