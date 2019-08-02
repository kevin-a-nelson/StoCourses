class Course < ApplicationRecord
  has_many :course_classes, foreign_key: :lab_id, class_name: 'CourseLab'
  has_many :courses, through: :course_classes

  has_many :course_labs, foreign_key: :course_id, class_name: 'CourseLab'
  has_many :labs, through: :course_labs

  validates :clbid, uniqueness: true
end
