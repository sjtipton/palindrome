class Student < ActiveRecord::Base
  attr_accessible :first_name, :institution_id, :last_name

  belongs_to :institution
  has_many :enrollments

  def enrolled_course_lesson_plan
    enrollment = Enrollment.find_by_student_id(self.id)
    instructor = Instructor.find_by_course_id(enrollment.course_id)
    student_lesson_plans = LessonPlan.find_by_instructor_id(instructor.id)
  end
end
