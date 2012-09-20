namespace :db do
  desc "Fill tables with sample data"
  task :add_sample_data => :environment do
    add_institutions
  end
end

def add_institutions
  4.times do
    institution = Institution.new
    institution.name = Forgery(:name).company_name
    institution.save
  end
end