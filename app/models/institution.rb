class Institution < ActiveRecord::Base
  attr_accessible :name

  has_many :instructors
end
