namespace :db do
  desc "Fill tables with sample data"
  task :add_sample_data => :environment do
    add_institutions
    add_courses
    add_instructors
    add_students
    add_enrollments
    add_lesson_plans
    add_lesson_plans_resources
  end
end

def add_institutions
  Institution.destroy_all
  Forgery.dictionaries[:institutions].each do |i|
    institution = Institution.create!(name: i)
  end
end

def add_courses
  Course.destroy_all
  Forgery.dictionaries[:courses].each do |c|
    course = Course.create!(name: c)
  end
end

def add_instructors
  Instructor.destroy_all
  courses = Course.all
  courses.each do |c|
    instructor = Instructor.new
    instructor.first_name = Forgery(:name).first_name
    instructor.last_name = Forgery(:name).last_name
    instructor.institution_id = 1
    instructor.course_id = c.id
    instructor.save
  end
end

def add_students
  Student.destroy_all
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
  Enrollment.destroy_all
  students = Student.all
  courses = Course.all
  students.each do |s|
    courses.each do |c|
      enrollment = Enrollment.new(course_id:c.id, student_id:s.id)
      enrollment.save
    end
  end
end

def add_lesson_plans
  LessonPlan.destroy_all
  instructors = Instructor.all
  count = 1
  instructors.each do |i|
    lp = LessonPlan.new
    lp.title = 'Lesson Plan ' + count.to_s
    lp.topic = 'algebra, math, grade 8'
    lp.description = Forgery(:lorem_ipsum).words(10)
    lp.instructor_id = i.id
    lp.rating = [1,2,3,4,5].sample
    lp.save
    count += 1
  end
end

def add_lesson_plans_resources
  LessonPlanResource.destroy_all
  r_id = ['096c615226f94c408f2c2d7a03f69ba3',
          '632c868103644f7e8b046a1e60dea0ab',
          '80fea543b1964ca6a1bd9efcb80742a0']
  lesson_plans = LessonPlan.all
  lesson_plans.each do |lp|
    lpr = LessonPlanResource.new
    lpr.lesson_plan_id = lp.id
    lpr.resource_id = r_id.sample
    lpr.save
  end
end