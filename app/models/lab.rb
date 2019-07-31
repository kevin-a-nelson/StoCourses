class Lab < ApplicationRecord
  has_many :course_labs
  has_many :courses, through: :course_labs
end
