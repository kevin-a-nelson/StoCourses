class CourseProf < ApplicationRecord
  belongs_to :course
  belongs_to :prof
end
