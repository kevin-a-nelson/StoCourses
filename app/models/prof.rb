class Prof < ApplicationRecord
  validates :f_name, :l_name, :rating, :num_ratings, :tid, presence: true
  validates :tid, uniqueness: true

  has_many :course_profs
  has_many :courses, through: :course_profs
end
