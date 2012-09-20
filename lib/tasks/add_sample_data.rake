namespace :db do
  desc "Fill tables with sample data"
  task :add_sample_data => :environment do
    add_institutions
    add_courses
    add_instructors
    add_students
    #add_enrollments
  end
end

def add_institutions
  Forgery.dictionaries[:institutions].each do |i|
    institution = Institution.create!(name: i)
  end
end

def add_courses
  Forgery.dictionaries[:courses].each do |c|
    course = Course.create!(name: c)
  end
end

def add_instructors
  5.times do
    c = Course.all
    i = Institution.all
    instructor = Instructor.new
    instructor.first_name = Forgery(:name).first_name
    instructor.last_name = Forgery(:name).last_name
    instructor.institution_id = i.sample.id
    instructor.course_id = c.sample.id
    instructor.save
  end
end

def add_students
  25.times do
    i = Institution.all
    student = Student.new
    student.first_name = Forgery(:name).first_name
    student.last_name = Forgery(:name).last_name
    student.institution_id = i.sample.id
    student.save
  end
end

def add_enrollments
  students = Student.all
  courses = Course.all
  students.each do |s|
    courses.each do |c|
      enrollment = Enrollment.new(course_id:c.id, student_id:s.id)
      enrollment.save
    end
  end
end