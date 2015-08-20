class Classroom < ActiveRecord::Base
  validates_presence_of :student, :course
  belongs_to :student
  belongs_to :course
end
