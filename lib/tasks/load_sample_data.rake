namespace :db do
  desc "Fill tables with sample data"
  task :add_sample_data => :environment do
    add_institutions
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