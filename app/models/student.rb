class Student < ActiveRecord::Base
  validates_presence_of :name, :register_number
  has_many :classrooms
  has_many :courses, through: :classrooms

  accepts_nested_attributes_for :classrooms
end 
