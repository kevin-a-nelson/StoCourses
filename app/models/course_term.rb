class CourseTerm < ApplicationRecord
  belongs_to :course
  belongs_to :term
end
