class CourseLab < ApplicationRecord
  belongs_to :lab, class_name: 'Course'
  belongs_to :course, class_name: 'Course'
end
