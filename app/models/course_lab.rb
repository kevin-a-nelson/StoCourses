class CourseLab < ApplicationRecord
  belongs_to :lab, class_name: 'Course'
  belongs_to :course, class_name: 'Course'
  # validates :course_lab, [:course_id, :lab_id], uniqueness: true
end
