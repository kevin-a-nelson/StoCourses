class Term < ApplicationRecord
  belongs_to :planner

  has_many :course_terms
  has_many :courses, through: :course_terms
end
